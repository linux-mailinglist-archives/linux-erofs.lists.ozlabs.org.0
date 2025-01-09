Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BCA073E0
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 11:56:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTMDC40c6z3bxZ
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 21:56:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736420202;
	cv=none; b=naL6UYIOCpn0l1CpYAzFAwR8jLtxO5uo+lCXpLFe5Ur5bam9myKyID6Lf6398pdE1uqe/GtzESjjkYTqRVBjoAP8SkED2FnzFA6ze9u5e6A5PrIEJGeYwa+wMTYdrFfxd+MqWKKOpbwYE872ifZ2tIwa/pfwNj5Y2rQKzNkyB8LJUapbXFZBcQ3ERPmvBgj4IKzcsba3+oSvWuxyOwszcIH9PSgWpve2VMoJjZdRU5POhhzYiyc21ij7aQ1vNxPYt2XFJ7J7HV9uO0oA6aI+hAVjACbgd6iAprmEzoLoJwZC3CYSivrJo8xv0RREgo1gvdORZcDGddwJNr6N4Yj/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736420202; c=relaxed/relaxed;
	bh=QQ6HS2GhOiVkY/KVoMG9McaukUbAnJ8NdOujCwKS958=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dDpNqlreVv2Bm3/c6ePeyFC0GwayDt/BpIlDssQ3aUc8n0dJofMf+maGFvvtu0EsjJqExbkXLrCVqMup4gev9HAFc7RMcYmTWURlv3rIJDabm/lTZESSvByXHobNZE4B12XhjaV0qNKbC5+hJmB/dQ3+RpdUVgkg3jd/4VZ+uc1oF3Vbf1MjYDdj6uxls1PeAIYCb3ygCi/XVBpGJKio2MyfuvTcbFksqHuLMSIygJkkUzOF/n6+U1yOrE65xTfVPi9E06i5KYimHst5yBncNnHr/Phuk7rIREt/5Iv3lsZOsXkivydgpFsM52EonGKJeRpiR21cZ/iCbC0RWHUujQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtHPXoX7; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtHPXoX7; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhernand@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtHPXoX7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtHPXoX7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhernand@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTMD931Djz30gC
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jan 2025 21:56:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736420195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ6HS2GhOiVkY/KVoMG9McaukUbAnJ8NdOujCwKS958=;
	b=WtHPXoX7XL/fob4QwzLhpisLIPvxjnbKGiZzwaAWTwUuxnJkp0epc4BmZYjN4rrLkj8PkP
	SyMG11nWRxJJFipxeQyh9MVMrLEMGUWn411jOP7NexcBhLa3xk6v2tl4y3tDHxu0oU7IKa
	yolSWgQYXAeX/H3E+yR4lrt/6Pei9s8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736420195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ6HS2GhOiVkY/KVoMG9McaukUbAnJ8NdOujCwKS958=;
	b=WtHPXoX7XL/fob4QwzLhpisLIPvxjnbKGiZzwaAWTwUuxnJkp0epc4BmZYjN4rrLkj8PkP
	SyMG11nWRxJJFipxeQyh9MVMrLEMGUWn411jOP7NexcBhLa3xk6v2tl4y3tDHxu0oU7IKa
	yolSWgQYXAeX/H3E+yR4lrt/6Pei9s8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-f6U1hZZsO1uYwGwYxPaNcw-1; Thu, 09 Jan 2025 05:56:34 -0500
X-MC-Unique: f6U1hZZsO1uYwGwYxPaNcw-1
X-Mimecast-MFC-AGG-ID: f6U1hZZsO1uYwGwYxPaNcw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so375024f8f.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jan 2025 02:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736420191; x=1737024991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ6HS2GhOiVkY/KVoMG9McaukUbAnJ8NdOujCwKS958=;
        b=PXSrwuuPV/mY710TsQwMQAlXSh15x4yrcyp3VBzlk51KLu69xheHSDrNZ6xY6sI0ZA
         6gOtYHslI2Txh2Fad7wfUJalALc+QbHP5OfIQR+vo2bti0XjAFusNmcMXe5oZmnY/8ue
         09VfpLsZnO8J1fHkV4aomTugF+xQuq83NV58AQwBeAghxRmfJyfuQyO7n7p022H20OSH
         d+EZwBQTJgCLiYkoNa/6Rgr+7Rf1dxmdoIxZbdF+WdaZ3JheEiDAD5ojKgocs6haM9oa
         onx6KeGHlNk7bDinCK3eE7H36S2GhGfNzP/rEQoRLYmdeogI1LCbt4h1TVbL6iFgIxd/
         1+9g==
X-Gm-Message-State: AOJu0YyF5E5bR+c6lZTgQxzByCN6T1H7jLH4geoT0eVe5GBA8VcgDhkY
	syJIUm6PMtby62FNSfUlD5vFrnzHxs0vN+EQPHcANE1mou/6DcJvXF5KCUEci2zvJwMMk+CGkp4
	xWB/GakTlomfJM+Av+l8leRi7nJEI5t4Sf+eV7uIbNITpFgtjnRLCp59K8TSQC496e7jFSxG2Yx
	7UagQ21xlxmn8osmLDkve2+5AOyYg9Yv8vKfctchxN0UgJGdCH
X-Gm-Gg: ASbGncuwT3GubNlgHA1Ej/L8TTbxfq4m3pj6fyYXOO5C9TI46QqqX/rBCsifzTrN5+W
	bmSmuNYgfPB9g1D1oFASBO7S9ZWSHTZaCJCN7tnEJUNO983v164ObJuUl8ChZv3wLVBEnNdO9RU
	VGrhTSbC7HeyZElKe5Tnzxc+tW1uHuQPZztKcsCp3SU3UID2Ne7n4iYPVBvr59sLqlWsQ21QA9a
	E6izYYXF+prGJW6a7aDqDnfZdvRHO2ONGuxEZqvrzcGSeGiovvsXz/CGU7eBsUGiHhQGHlNgIKX
	03dmM8me5igR8ddDW25T
X-Received: by 2002:a05:6000:709:b0:386:4277:6cf1 with SMTP id ffacd0b85a97d-38a8733a278mr5542563f8f.39.1736420191092;
        Thu, 09 Jan 2025 02:56:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH17TrNL9+gm1G0rx6eQvVxrxpBEoKY1+4XM8jS74Zsu/bf8vHy/O9QRePHstIFJr1lYB859Q==
X-Received: by 2002:a05:6000:709:b0:386:4277:6cf1 with SMTP id ffacd0b85a97d-38a8733a278mr5542533f8f.39.1736420190600;
        Thu, 09 Jan 2025 02:56:30 -0800 (PST)
Received: from localhost (134.red-88-26-127.staticip.rima-tde.net. [88.26.127.134])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38a8e38c6a2sm1490995f8f.54.2025.01.09.02.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 02:56:30 -0800 (PST)
From: Juan Hernandez <jhernand@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: Add --cat flag to show file contents
Date: Thu,  9 Jan 2025 11:56:11 +0100
Message-ID: <20250109105611.178398-1-jhernand@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CABxE0VzSbSsdoefYCg+cDP=TP9-tMARHr9D9mvrYtrkCY-aucw@mail.gmail.com>
References: <CABxE0VzSbSsdoefYCg+cDP=TP9-tMARHr9D9mvrYtrkCY-aucw@mail.gmail.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ne_vWDhChP_g044jnU3369OGTH3U69ro0eQcL2XGhUI_1736420193
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
 dump/main.c      | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 man/dump.erofs.1 | 13 ++++++++--
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 372162e..860ee5a 100644
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
@@ -672,6 +678,56 @@ static void erofsdump_show_superblock(void)
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
 int main(int argc, char **argv)
 {
 	int err;
@@ -696,6 +752,15 @@ int main(int argc, char **argv)
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

