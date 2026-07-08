Return-Path: <linux-erofs+bounces-3861-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wLGJF84ZTmr/DAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3861-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 11:35:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A9723C87
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 11:35:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="hGAB74/n";
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=J3WueXgF;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3861-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3861-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwCcR5rhkz2xpn;
	Wed, 08 Jul 2026 19:35:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783503303;
	cv=none; b=DV+xL9xF1V+gK3dPpAcM4PR1EA48to/5cD67pvFPxTM51JaendcwBY1MB0bmN7yGvlxf1ry4Zv91nPiA0gUxf5o4oFqn/jK2UAQoiBPdcgmdmB5c4ailagCdiR2vN+sbfsNTsjAeoWqPri6C3d7IwLNTwXbTTJh36kRBiK2M27f8iwl2Co6L0KrxotroYLq/EdnfsBhFmJ5566qudJSfEnVyzH2O0ZuypqJaVdlkjUTd8EE+eceueRGV6rSGIuzAEprW9M6XQqzLmc/rm/DDmagvqbLpRwQz49w3Po6ztbNFUbchXLS7m6soH/MBSHo9q/0qg7HFg0z84UoyMWgDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783503303; c=relaxed/relaxed;
	bh=jpQHmVZWu/cPOGUIrg9MSqvGn+4kpt3IxztqRSV+J7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=l0DCpxK6uhOoY3a0/OuCHsKX3Dnzj1H6TOdjVPj3KuN5MIvG9d8utwX0s7GF8eg81dEoa/Lqpu0VWP56/8/Qxa+RFxfa4DHbKrNyuthUqtjhc53MsxTqKraAsDvEb/LmR/V7PbYNGYawyiH8wQ3z9MAODiHQ1jaikARGoB5Om6202/rIhmA1hKZAXKZOBWfPxtSs/MGVzaGHUM+3afy7B0rJWgxw3iOwUjXDT7FUpUjLQ5UkrwUvjgkiPG72vZmEVhvIrDm8V9HeskZUtl4rzJHvFase6m8pWMWjFOnai1x/CdCtXg4EfPQRyNxbWmKxxJ3CV9F+kJQ48xkIiuSCvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGAB74/n; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J3WueXgF; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=gscrivan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwCcP5z0Wz308f
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 19:35:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783503298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpQHmVZWu/cPOGUIrg9MSqvGn+4kpt3IxztqRSV+J7U=;
	b=hGAB74/n2v+ZkyFHxLLgIrIbUX5aOIOaIOg105EHvJ9GkFw+TU98eehHvZYTvKMF3tvYwo
	ImR/2QsoyA08Zb4LgeQC2UFByJOg6Nk8m7swp1sybewN0aV7dJl3PE4y4AQ6wwA5Wie2S4
	UVW0oK9fkexyfTxDHeQkZhxRmafGEAI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783503299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpQHmVZWu/cPOGUIrg9MSqvGn+4kpt3IxztqRSV+J7U=;
	b=J3WueXgFS6bBfPN1CCU+TnT1FvyAqjw/FDJ6GFg7WYjXVSQAk72nn3unZXL+YFUSx2/TkD
	3FRUSKZ/YSd6c6aqaD5p9FP8WJhpCjGuoxT9Fo9/niDdnniizTiNhCYXw5uBUd4RNFC6r/
	WD5HPONeB1fjBFImh8yBKNWlDogkbfQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-LG3sZ6g7MXOdEE8BqjtmHQ-1; Wed,
 08 Jul 2026 05:34:54 -0400
X-MC-Unique: LG3sZ6g7MXOdEE8BqjtmHQ-1
X-Mimecast-MFC-AGG-ID: LG3sZ6g7MXOdEE8BqjtmHQ_1783503294
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E40C41800BD4;
	Wed,  8 Jul 2026 09:34:53 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC8A51955F7B;
	Wed,  8 Jul 2026 09:34:52 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH 2/2] erofs: add ioctl to retrieve the backing source file descriptor
Date: Wed,  8 Jul 2026 11:34:27 +0200
Message-ID: <20260708093446.3370200-3-gscrivan@redhat.com>
In-Reply-To: <20260708093446.3370200-1-gscrivan@redhat.com>
References: <20260708093446.3370200-1-gscrivan@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 8Eo-irHpEFuyEs9tystCo-bQW7HsmRNZU9m2mPzwBwc_1783503294
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3861-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE9A9723C87

Add EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor to the
backing image file for file-backed erofs mounts.

Returns -ENOENT for block-device-backed erofs mounts where there is no
backing file.

The UAPI constant is defined in include/uapi/linux/erofs.h.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/erofs/inode.c           | 25 +++++++++++++++++++++++++
 include/uapi/linux/erofs.h |  9 +++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/uapi/linux/erofs.h

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 45afe5c50de8..0a38cb5cfc5d 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -6,6 +6,8 @@
  */
 #include "xattr.h"
 #include <linux/compat.h>
+#include <linux/file.h>
+#include <uapi/linux/erofs.h>
 #include <trace/events/erofs.h>
 
 static int erofs_fill_symlink(struct inode *inode, void *bptr, unsigned int ofs)
@@ -356,6 +358,27 @@ static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)
 	return ret ? -EFAULT : 0;
 }
 
+static int erofs_ioctl_get_source_fd(struct file *filp)
+{
+	struct erofs_sb_info *sbi = EROFS_I_SB(file_inode(filp));
+	struct file *f;
+	int fd;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!erofs_is_fileio_mode(sbi))
+		return -ENOENT;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	f = get_file(sbi->dif0.file);
+	fd_install(fd, f);
+	return fd;
+}
+
 long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -364,6 +387,8 @@ long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	case FS_IOC_GETFSLABEL:
 		return erofs_ioctl_get_volume_label(inode, argp);
+	case EROFS_IOC_GET_SOURCE_FD:
+		return erofs_ioctl_get_source_fd(filp);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/erofs.h b/include/uapi/linux/erofs.h
new file mode 100644
index 000000000000..17c835785ea9
--- /dev/null
+++ b/include/uapi/linux/erofs.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_EROFS_H
+#define _UAPI_LINUX_EROFS_H
+
+#include <linux/ioctl.h>
+
+#define EROFS_IOC_GET_SOURCE_FD	_IO('e', 1)
+
+#endif /* _UAPI_LINUX_EROFS_H */
-- 
2.55.0


