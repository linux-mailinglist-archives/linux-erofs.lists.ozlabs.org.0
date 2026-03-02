Return-Path: <linux-erofs+bounces-2466-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIfGCtbfpWkvHgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2466-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 20:07:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537D1DE9E2
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 20:07:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPpMQ2p7zz3bn7;
	Tue, 03 Mar 2026 06:06:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4601:b100::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772478418;
	cv=none; b=h2OasoHch4bV/dxKwOvH5B5JvNXxqkGE9EbU2XaRNhVfWD0pGpmFFxNjpslo0Rb8LrZtYASa7+wnarhmJOehhdYeaw37UQFFXuQtVY25C055g6+AIZ72F5cG0FsvJ98aR0pcGPMuEjiE+8BLHtd7zQCSTcU7K8CAwSD0JjLc8Dp6XEu/8Pfivh2+wH+OqZPB/My5vA6iwW8lqIXzc4k21P/MIfV90W0xDv+UxoOKxgKV/UlCAO59mvEp/huhJWHp0dDrjGWR7WG/KVjNVSeMWN1SlsOsXvjWpHCK27E2kfJlZOF54rx9YAQzxIWGxqp3FD+Wzm58fOwpOwOTt1CoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772478418; c=relaxed/relaxed;
	bh=k8ZSH07tyZ0idvTPEoa7H6yFCPCit65BlgAgcs0OFCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f+dKzivDz+Z9zWdlXh4VntnHK18iXgblbqaBDAsUnWQhYbZJNcFppzVdkpREqnITjURzJDEExQ3c8FO0QubJjR1xZkYL6oAT0AuSF73KHLRQVUio9I00i9+76/Izdxy3k5pvTvFoOG08/PjMJI8nZo7fleO3n2PC3YGyav6Zg48VfnnoyzMmoyOXLuO+0EPy8MZmeQL0b/bn0a5A6JDa2YIjErnVELw/5NMrul1xAsI/mKcySw7NOIKbnYEy1Y7RbJkzBWZC+EezmcGut9qGxNKblBhjhRa4zWv6zAXWkfXHAhrt76lXLCAiV19QoXpVNgwab18XfJEDOubbcmFmMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=recoil.org; dkim=pass (1024-bit key; secure) header.d=recoil.org header.i=@recoil.org header.a=rsa-sha256 header.s=selector1 header.b=M64xB/7o; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4601:b100::1; helo=honk.recoil.org; envelope-from=dave@recoil.org; receiver=lists.ozlabs.org) smtp.mailfrom=recoil.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=recoil.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=recoil.org header.i=@recoil.org header.a=rsa-sha256 header.s=selector1 header.b=M64xB/7o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=recoil.org (client-ip=2604:1380:4601:b100::1; helo=honk.recoil.org; envelope-from=dave@recoil.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 342 seconds by postgrey-1.37 at boromir; Tue, 03 Mar 2026 06:06:56 AEDT
Received: from honk.recoil.org (honk.recoil.org [IPv6:2604:1380:4601:b100::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPpMN5qztz3bn4
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 06:06:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=recoil.org;
	s=selector1; t=1772478068;
	bh=5A7Z1S1wxrFT5pBpvxtzGXA5nX7j4KJk+ONJO9F9EiI=;
	h=Date:From:To:Cc:Subject:From;
	b=M64xB/7oPkbK8v1bRHvrQFuet8qqUfIp2aEXb91DixHmLqV/HBxOOnfqPX4gF8PfX
	 gWw+D83W1U0bC7dzto388jcEXqw+/kiHw04AjG9tGD/1sG3AMwgXep3arhy8hhko+h
	 Hc/0rdQoXziOehPQ5ME+bEZK4UhAiUPQ2AiCeBhs=
Received: from beast (unknown [IPv6:2a02:390:54be:0:4762:4731:f1c0:f015])
	by honk.recoil.org (Postfix) with ESMTPSA id 7B9381780733;
	Mon,  2 Mar 2026 19:01:08 +0000 (UTC)
Date: Mon, 2 Mar 2026 19:01:07 +0000
From: David Scott <dave@recoil.org>
To: linux-erofs@lists.ozlabs.org
Cc: dave.scott@docker.com, dave@recoil.org
Subject: [PATCH] erofs-utils: mkfs: fix CPU spin using --tar=f when stdin is
 closed
Message-ID: <aaXec59gbj8fIXai@beast>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 3537D1DE9E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[recoil.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[recoil.org:s=selector1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[recoil.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-2466-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave@recoil.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action

On my Mac I saw a CPU spin which looked like this:
```
Call graph:
    2192 Thread_132504   DispatchQueue_1: com.apple.main-thread  (serial)
      2192 start  (in dyld) + 6992  [0x185bcbda4]
        2192 main  (in mkfs.erofs) + 7916  [0x10253a6d0]
          2192 tarerofs_parse_tar  (in mkfs.erofs) + 5492  [0x102551d48]
            2187 tarerofs_write_file_data  (in mkfs.erofs) + 140  [0x102551fe0]
            + 2187 write  (in libsystem_kernel.dylib) + 8  [0x185f47834]
            4 tarerofs_write_file_data  (in mkfs.erofs) + 116  [0x102551fc8]
            + 4 erofs_iostream_read  (in mkfs.erofs) + 16,36,...  [0x10254fa28,0x10254fa3c,...]
            1 tarerofs_write_file_data  (in mkfs.erofs) + 140  [0x102551fe0]
```

The input stream was closed prematurely, so the reads returned 0 (EOF),
which wasn't considered an error.

Treat return of 0 (EOF) as an error.

Reproduce by:
```
dd if=/dev/zero bs=1024 count=4 2>/dev/null > /tmp/testfile
COPYFILE_DISABLE=1 tar cf - -C /tmp testfile | head -c 2048 > /tmp/truncated.tar
./mkfs/mkfs.erofs --tar=f output.erofs < /tmp/truncated.tar
```
Before the patch this will hang, after it should fail as expected.

(COPYFILE_DISABLE tells mac to avoid putting extra stuff in the tar)

Closes: https://github.com/erofs/erofs-utils/issues/43
Signed-off-by: David Scott <dave@recoil.org>
---
 lib/tar.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 178f843..57c6fee 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -638,8 +638,11 @@ static int tarerofs_write_uncompressed_file(struct erofs_inode *inode,
 
 	for (pos = 0; pos < inode->i_size; pos += ret) {
 		ret = erofs_iostream_read(&tar->ios, &buf, inode->i_size - pos);
-		if (ret < 0)
+		if (ret <= 0) {
+			if (!ret)
+				ret = -EIO;
 			break;
+		}
 		if (erofs_dev_write(sbi, buf,
 				    erofs_pos(sbi, inode->u.i_blkaddr) + pos,
 				    ret)) {
@@ -649,6 +652,8 @@ static int tarerofs_write_uncompressed_file(struct erofs_inode *inode,
 	}
 	inode->idata_size = 0;
 	inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+	if (ret < 0)
+		return ret;
 	return 0;
 }
 
@@ -673,8 +678,11 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 
 	for (j = inode->i_size; j; ) {
 		nread = erofs_iostream_read(&tar->ios, &buf, j);
-		if (nread < 0)
+		if (nread <= 0) {
+			if (!nread)
+				nread = -EIO;
 			break;
+		}
 		if (pwrite(fd, buf, nread, off) != nread) {
 			nread = -EIO;
 			break;
@@ -684,6 +692,8 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 	}
 	erofs_diskbuf_commit(inode->i_diskbuf, inode->i_size);
 	inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
+	if (nread < 0)
+		return nread;
 	return 0;
 }
 
-- 
2.43.0


