Return-Path: <linux-erofs+bounces-2486-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EPhM9O1pmk7TAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2486-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 11:20:03 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C341B1EC936
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 11:20:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQBct68F7z3bn4;
	Tue, 03 Mar 2026 21:19:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772533198;
	cv=none; b=QIl7LfKLNY9iweTHK0FlYNjyf+lVU6sjQBiEh+hdQ6nB3fofSUpo3dl89u4PIfTHHQ6RxCVkM9p5b7G/9o66go/iXo4wxqbh8IxEnIM5cvjt1WDKDLl6dpImRb6KCumGS3dD7WkyVg3NMsm+8UUvHWe+1l+i0eibUBd4zyY3N+yYleZZ5Tw4mtpn50bOgYKFHW8Tr/taSRw6j1ITpt+4K9zu6+8n0UJlSv3JvmKtXAdCIxUwdJBDMqmoXGC4Usk3hAn1OPFn1Z0/WPcWFVwAq4oCKrR5N+rV2OEeBE3j+ynGQdXbuRIJQQHWBPScS3qfI8er6KCNFXAYFvk3hFbkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772533198; c=relaxed/relaxed;
	bh=lMGGmM5CoHQG1KpK8+DG4Y7WOEa0PtEj7KYsnosE264=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzxyyJ2wMn90DJoyxn5nEQMJMvMCC0sbNvn+2Tu5b12BR+fAZIc7QosWbXL5E3D+9IoxLDBHARrklRsOqCPFD6+GMA+xCNoTj59A7YRYib45gx0VZ/Uj79y1ybN487e+XWM7jS9Bf2rnAEsvl/Q2UEkQ+zH0oqv67wPelpqIxUeD8erYYVQmxqLC6oLqjvIjSgMgJ5QiRh8aZ4aOm4CZ6u081YbmsK75Ik8pwoyD0Oek7u8/t/Hq9VFoy2gmCkNNP/EvXGMvnf8uwjl1tZdYa7BINkCOhFlPxsOAahbgZ7Qm2ONOidmg0O/Go5xJlZLzx7UfwH/2XIUn9QphMCaA9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=faCH2Hq+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=faCH2Hq+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQBcr4q3cz30Lw
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 21:19:54 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772533189; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lMGGmM5CoHQG1KpK8+DG4Y7WOEa0PtEj7KYsnosE264=;
	b=faCH2Hq+thhZZBhOcBXqgQOYU3OZM3W7pKxmSm3qvXHhc+ah1T1T2k0g42xGmLdSeohf9aRNguIEjHX5gEkwOSZUMlr8gtpkVNUHrIQ16gOHIiAtPqQ2qI0wdWvwiAREnfR+JE5TyM1yKFADKi9XhG6FbKxWm1UpIwm7lYOmO0U=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-9Xmz._1772533184 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 18:19:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mount: handle `-oloop` in the mount helper
Date: Tue,  3 Mar 2026 18:19:24 +0800
Message-ID: <20260303101924.1541818-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: C341B1EC936
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2486-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Action: no action

Generally, mount(8) does not pass the `-oloop` option to the mount
helper.

However, in case that users invoke `mount.erofs` directly, let's
handle this option here as well.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mount/main.c b/mount/main.c
index dbee2ec..3ef4e9c 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -64,6 +64,7 @@ static struct erofsmount_cfg {
 	long flags;
 	enum erofs_backend_drv backend;
 	enum erofsmount_mode mountmode;
+	bool force_loopdev;
 } mountcfg = {
 	.full_options = "ro",
 	.flags = MS_RDONLY,		/* default mountflags */
@@ -225,7 +226,9 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 		if (comma)
 			*comma = '\0';
 
-		if (strncmp(s, "oci", 3) == 0) {
+		if (!strcmp(s, "loop")) {
+			mountcfg.force_loopdev = true;
+		} else if (strncmp(s, "oci", 3) == 0) {
 			/* Initialize ocicfg here iff != EROFSNBD_SOURCE_OCI */
 			if (nbdsrc.type != EROFSNBD_SOURCE_OCI) {
 				erofs_warn("EXPERIMENTAL OCI mount support in use, use at your own risk.");
@@ -1530,6 +1533,9 @@ int main(int argc, char *argv[])
 		goto exit;
 	}
 
+	if (mountcfg.force_loopdev)
+		goto loopmount;
+
 	err = mount(mountcfg.device, mountcfg.target, mountcfg.fstype,
 		    mountcfg.flags, mountcfg.options);
 	if (err < 0)
@@ -1539,6 +1545,7 @@ int main(int argc, char *argv[])
 		err = erofsmount_fuse(mountcfg.device, mountcfg.target,
 				      mountcfg.fstype, mountcfg.full_options);
 	else if (err == -ENOTBLK)
+loopmount:
 		err = erofsmount_loopmount(mountcfg.device, mountcfg.target,
 					   mountcfg.fstype, mountcfg.flags,
 					   mountcfg.options);
-- 
2.43.0


