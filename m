Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF0A07242
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 10:56:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTKtZ73F7z3by8
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 20:56:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736416581;
	cv=none; b=TulCPgsRKHTPY/2yqLQsN5HKEs/3LsT7fIqMSpGA36R3PMFPD1TfzxUMjPse5h61T9BiLvgHuKOOyjZ7BMcN3uDS0KCof83EmAbkeRla5D6Y/cxO6OxIfl/85f97kW2MtpoyzYDRCWUU7UCWALiFzHnXetE3Kv/nPcNuMKEt8/BH68OaIn5Al/04TYKb4Pv5MD6hrC0LBWoHzPZPdQlL+qk66NAY+a0mNtNAEid0miN8t9Ncc7W7BHZ0il/LqQDdpt8DjmiGpJbjFQ/bgCYgpyAw+/V1dC++A5slCrhtUc82bFv+UjLT236yd78tI592dwL536SZxqSd47AoPJIsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736416581; c=relaxed/relaxed;
	bh=RP4XPhSwqq3BEPB6xpoO7F7/NITMzYJd7XASb7R4HE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=dUIIYy1PanSkyXpIXLkRxdlzCIsaT9p0+TumXbfZ/vbraPpRe+q3r2zBZxQ34JhNgA6LtkW1G21RuOQrgB/K66OnlbkBpHRsEat9uL7H/S5RgNamW2Y29iO7dlwz/+EP/xGY94Y0eNHtE33na1ILixR/P0TKVrKMe2Sf04q751BqWBBD2HOzz/OSyqjVkJgJqjRK0eugg2cPbBCboy6NhFWjMC8OkDxRDi4wFnjY+bPhat60cLFwZyMPqQWCsNQUU5D9RFxWifeKtFH8k/M7K1ENpVEXiNVzDqnqXVpjp2lXP9SX15yeC0Slzp8t/mUa7vKCS3DMjllVlrz/xCGvuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mc/EdMDn; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mc/EdMDn; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhernand@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mc/EdMDn;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mc/EdMDn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhernand@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTKtX1XVJz3bVK
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jan 2025 20:56:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736416574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RP4XPhSwqq3BEPB6xpoO7F7/NITMzYJd7XASb7R4HE4=;
	b=Mc/EdMDnUwPfOqGlsc2XF+28UE2UOsc6jw2iOFM35oKgGaPBDtrFaTeKe17X7Mio5KjWwG
	Xk4ehZcFrHktoxmuNg4FSqUjYRYGXB+aZdE6BPG29x3+ryLrC6gYV+mi0SmbE6EzgT2PC+
	aLbLJ6W8v0aW28QeBm2C+Jik2ZHILhE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736416574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RP4XPhSwqq3BEPB6xpoO7F7/NITMzYJd7XASb7R4HE4=;
	b=Mc/EdMDnUwPfOqGlsc2XF+28UE2UOsc6jw2iOFM35oKgGaPBDtrFaTeKe17X7Mio5KjWwG
	Xk4ehZcFrHktoxmuNg4FSqUjYRYGXB+aZdE6BPG29x3+ryLrC6gYV+mi0SmbE6EzgT2PC+
	aLbLJ6W8v0aW28QeBm2C+Jik2ZHILhE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-8TiY77TyMSOqTg0C3cbrVg-1; Thu, 09 Jan 2025 04:56:13 -0500
X-MC-Unique: 8TiY77TyMSOqTg0C3cbrVg-1
X-Mimecast-MFC-AGG-ID: 8TiY77TyMSOqTg0C3cbrVg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso4755105e9.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jan 2025 01:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736416571; x=1737021371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RP4XPhSwqq3BEPB6xpoO7F7/NITMzYJd7XASb7R4HE4=;
        b=Jg2Q7O24JyLUweJ6QVAt+szIfHNu0OQ3+rBgnU3q5Ym+C5+qQdguG8yNn76xHImSJl
         raCSx3uAaersVcOhmb9lzmioaJakiGHPkd86aCb3j+r9OjNZq+zqZ1k9oKFmp38q+MzT
         JvIOg0JdIEGLS9wmcZo0o28sD4xD/ufKR5qDiiWN3a0IF/KehT+SbH7TWk/sT5IMLm49
         3/ky61Ed3Yi58iBCkGYE75BtrZsWneAiP952iHzkPRexkVqo+kNPT8/IQhAP8M4w0Phy
         Qkef7ECWuotXA2sv6LBIgwkBISJJd0jElr4akwVm+fERNztyDso3Yo03Yc+cqe0GwKB1
         G2Xg==
X-Gm-Message-State: AOJu0YzMqfe8zZGnEu6uHD8f/grB2mgufGuVgixYx7SUK5fA3ffiIWwd
	xjI3kck+qjuFY73LU7YiT79D2YbtdwwNE3pbgvliFZYFFXtFuOoBbLRF+7w1fca6jP4HcTOPDob
	XCsFvGNjqleaRlppps2Zyu+Jpy/issjNAMuyyAAxImJW474z/7gaUe5Yizo82gLbx9fkeqGFdls
	im7LNj+2asp/5c1cuqh5AlkfWLZxs02aODXJZ5EyVm6Vnt70aC
X-Gm-Gg: ASbGnct71i4BahtQYwZnAWvW+Rkk48nkqvvRQ108ckMdWzViyciqkikmAgIadyTbwZA
	a2pTBdPTIS+cwgxOvRH/+1E/Xnz/VLgONnl6UaK7Z37sRA5XUe4Xl1jIvQvf8NTgkfDKsiAe/ky
	PVSFzYcVte3R/JOp2sAm97MbmpDiou+/Q2TqRTdrBuUaDm54GLObMx5TEt2cg+8EZ6SOnfLEAjI
	hKh58rxS4TQsGrfqcEK2x41z4LpeJv9/UpSxBQovjcbDjYoFGLPSGfOrqxuSnj1gWEJ/n/UW+JJ
	o4zNzdUEpG7W64iy12lg
X-Received: by 2002:a05:600c:3c9f:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-436e2686716mr53859235e9.4.1736416571284;
        Thu, 09 Jan 2025 01:56:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz0eiiQ8nq+zJPjVUYV/JTibshmNtvBdlZa0tk7gy1+OAG1CEk/OIHwbCR3svimed7Wxk9gA==
X-Received: by 2002:a05:600c:3c9f:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-436e2686716mr53858945e9.4.1736416570844;
        Thu, 09 Jan 2025 01:56:10 -0800 (PST)
Received: from localhost (134.red-88-26-127.staticip.rima-tde.net. [88.26.127.134])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-436e2da65a3sm50158445e9.7.2025.01.09.01.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 01:56:10 -0800 (PST)
From: Juan Hernandez <jhernand@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: Add --cat flag to show file contents
Date: Thu,  9 Jan 2025 10:55:26 +0100
Message-ID: <20250109095526.71911-1-jhernand@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mopH_PsGP8jgnYVqKirKSbIwWyx9MF1umeMSwT_bXQ4_1736416572
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Juan Hernandez <jhernand@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds a new '--cat' flag to the 'dump.erofs' command. When
used it will write to the standard output the content of the file
indicated by the '--path' or '--nid' options. For example, if there is a
'/mydir/myfile.txt' file containg the text 'mytext':

    $ dump.erofs --cat --path=/mydir/myfile.txt myimage.erofs
    mytext

Signed-off-by: Juan Hernandez <jhernand@redhat.com>
---
 dump/main.c      | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 man/dump.erofs.1 | 13 +++++++--
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 372162e..ed8d44d 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -26,6 +26,7 @@ struct erofsdump_cfg {
 	bool show_superblock;
 	bool show_statistics;
 	bool show_subdirectories;
+	bool show_file_content;
 	erofs_nid_t nid;
 	const char *inode_path;
 };
@@ -80,6 +81,7 @@ static struct option long_options[] = {
 	{"path", required_argument, NULL, 4},
 	{"ls", no_argument, NULL, 5},
 	{"offset", required_argument, NULL, 6},
+	{"cat", no_argument, NULL, 7},
 	{0, 0, 0, 0},
 };
 
@@ -123,6 +125,7 @@ static void usage(int argc, char **argv)
 		" -s              show information about superblock\n"
 		" --device=X      specify an extra device to be used together\n"
 		" --ls            show directory contents (INODE required)\n"
+		" --cat           show file contents (INODE required)\n"
 		" --nid=#         show the target inode info of nid #\n"
 		" --offset=#      skip # bytes at the beginning of IMAGE\n"
 		" --path=X        show the target inode info of path X\n",
@@ -186,6 +189,9 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 				return -EINVAL;
 			}
 			break;
+		case 7:
+			dumpcfg.show_file_content = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -672,6 +678,63 @@ static void erofsdump_show_superblock(void)
 			uuid_str);
 }
 
+static void erofsdump_show_file_content(void)
+{
+	int err;
+	struct erofs_inode inode = { .sbi = &g_sbi, .nid = dumpcfg.nid };
+	size_t buffer_size;
+	char *buffer_ptr;
+	erofs_off_t pending_size;
+	erofs_off_t read_offset;
+	erofs_off_t read_size;
+
+	if (dumpcfg.inode_path) {
+		err = erofs_ilookup(dumpcfg.inode_path, &inode);
+		if (err) {
+			erofs_err("read inode failed @ %s", dumpcfg.inode_path);
+			return;
+		}
+	} else {
+		err = erofs_read_inode_from_disk(&inode);
+		if (err) {
+			erofs_err("read inode failed @ nid %llu", inode.nid | 0ULL);
+			return;
+		}
+	}
+
+	if (!S_ISREG(inode.i_mode)) {
+		erofs_err("not a regular file @ nid %llu", inode.nid | 0ULL);
+		return;
+	}
+
+	buffer_size = erofs_blksiz(inode.sbi);
+	buffer_ptr = malloc(buffer_size);
+	if (!buffer_ptr) {
+		erofs_err("buffer allocation failed @ nid %llu", inode.nid | 0ULL);
+		return;
+	}
+
+	pending_size = inode.i_size;
+	read_offset = 0;
+	while (pending_size > 0) {
+		read_size = pending_size > buffer_size? buffer_size: pending_size;
+		err = erofs_pread(&inode, buffer_ptr, read_size, read_offset);
+		if (err) {
+			erofs_err("read file failed @ nid %llu", inode.nid | 0ULL);
+			goto out;
+		}
+		pending_size -= read_size;
+		read_offset += read_size;
+		fwrite(buffer_ptr, read_size, 1, stdout);
+	}
+	fflush(stdout);
+
+out:
+	free(buffer_ptr);
+}
+
+
+
 int main(int argc, char **argv)
 {
 	int err;
@@ -696,6 +759,15 @@ int main(int argc, char **argv)
 		goto exit_dev_close;
 	}
 
+	if (dumpcfg.show_file_content) {
+		if (dumpcfg.show_superblock || dumpcfg.show_statistics || dumpcfg.show_subdirectories) {
+			fprintf(stderr, "The '--cat' flag is incompatible with '-S', '-e', '-s' and '--ls'.\n");
+			goto exit_dev_close;
+		}
+		erofsdump_show_file_content();
+		goto exit_dev_close;
+	}
+
 	if (!dumpcfg.totalshow) {
 		dumpcfg.show_superblock = true;
 		dumpcfg.totalshow = 1;
diff --git a/man/dump.erofs.1 b/man/dump.erofs.1
index 6237ead..ec823ec 100644
--- a/man/dump.erofs.1
+++ b/man/dump.erofs.1
@@ -8,7 +8,7 @@ or overall disk statistics information from an EROFS-formatted image.
 \fBdump.erofs\fR [\fIOPTIONS\fR] \fIIMAGE\fR
 .SH DESCRIPTION
 .B dump.erofs
-is used to retrieve erofs metadata from \fIIMAGE\fP and demonstrate
+is used to retrieve erofs metadata and data from \fIIMAGE\fP and demonstrate
 .br
 1) overall disk statistics,
 .br
@@ -16,7 +16,9 @@ is used to retrieve erofs metadata from \fIIMAGE\fP and demonstrate
 .br
 3) file information of the given inode NID,
 .br
-4) file extent information of the given inode NID.
+4) file extent information of the given inode NID,
+.br
+5) file content for the given inode NID.
 .SH OPTIONS
 .TP
 .BI "\-\-device=" path
@@ -32,6 +34,13 @@ or
 .I path
 required.
 .TP
+.BI "\-\-cat"
+Write file content to standard output.
+.I NID
+or
+.I path
+required.
+.TP
 .BI "\-\-nid=" NID
 Specify an inode NID in order to print its file information.
 .TP
-- 
2.47.1

