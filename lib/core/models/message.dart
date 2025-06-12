enum MessageType { text, image, call }

class Message {
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isSentByMe; // To differentiate between sent and received messages
  final MessageType type; // New field
  final String? mediaUrl; // New field for image/file path
  final String? fileName;
  final String? fileSize;

  Message({
    required this.senderId,
    this.text = '',
    required this.timestamp,
    required this.isSentByMe,
    this.type = MessageType.text,
    this.mediaUrl,
    this.fileName,
    this.fileSize,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      text: json['text'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      isSentByMe:
          json['isSentByMe'] ?? false, // Default to false if not provided
      type: MessageType.values.firstWhere(
        (e) => e.toString() == 'MessageType.' + json['type'],
        orElse: () => MessageType.text,
      ), // Handle type
      mediaUrl: json['mediaUrl'],
      fileName: json['fileName'],
      fileSize: json['fileSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isSentByMe': isSentByMe,
      'type': type.toString().split('.').last,
      'mediaUrl': mediaUrl,
      'fileName': fileName,
      'fileSize': fileSize,
    };
  }
}
