Return-Path: <linux-erofs+bounces-2447-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEPiH90wpGnZaAUAu9opvQ
	(envelope-from <linux-erofs+bounces-2447-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 01 Mar 2026 13:28:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4841B1CF962
	for <lists+linux-erofs@lfdr.de>; Sun, 01 Mar 2026 13:28:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fP1Yf10bXz2yFK;
	Sun, 01 Mar 2026 23:28:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772368086;
	cv=none; b=dgigOUDCM4k2wo2wC3nGD1LyPO8tg4w+sLnuIzurk/xgyvdv3og5SYKALYMMkn+9ELICKqfId5UxAjLXTi66tV0byN2jeBS1jBA/e0ev2DqjV6cZ3wm4tlRX6r/JBbY5DLTNSYO+uaO6DfLkpBHXnJk1spXK9B9u+MpyNRogYX3Kfkbe6aB1LSShQDcE853I840Du6yUR7afJfdKxMRknMBXBp8Xe3opUBYfieO9du4NiEBIC33bTlzigzNjsjd2El0h5a9n66l+LM5I05n+DMn1P6OCLw4+rf+AsyhG+lk+RkMRA5fsH9VV4Lkot6nn/al+s0/R3MDh1wCaCAbpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772368086; c=relaxed/relaxed;
	bh=sGV16EqAn7Hfxn4QOUApjglvBnUGAg7wZqTLZmyoqQY=;
	h=Message-ID:From:To:Subject:Date:MIME-Version; b=YWTlF9qquGogN0w1qnYRcRKBoeNcWwvbh2I827ZgE9Tjba5sRn2U/xNjxzT/lXaNWQSCYWhk5nudACcoQ5ESqzdT8zBGyvbEE/0owvWy61ipEByDPWptfpsepj7dCZxq7wXbAD46y4t2CVJ+hJeeNKRhQZzGQbXeuVzMl9Ky9/j0mxVZtMZE+cTeth5sdeRSMGLdU1njDRnec72vxkLCaZi8VZOVs0LQzcei32HWyyfg83Q4rTFwsyAtngccP+QOdI600LsVW6XKv2p78LU+BAWeZDGkHY++BmA5g+c71MPcWLD9UqiIqyzkGlbhqV6xJl+idrp6gnGPYOOvkPEGog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=SQ1rgpCP; dkim-atps=neutral; spf=pass (client-ip=162.62.58.216; helo=out162-62-58-216.mail.qq.com; envelope-from=yifan.yfzhao@foxmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=foxmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=SQ1rgpCP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foxmail.com (client-ip=162.62.58.216; helo=out162-62-58-216.mail.qq.com; envelope-from=yifan.yfzhao@foxmail.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 11227 seconds by postgrey-1.37 at boromir; Sun, 01 Mar 2026 23:28:02 AEDT
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4fP1YZ4zbQz2xqm
	for <linux-erofs@lists.ozlabs.org>; Sun, 01 Mar 2026 23:28:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772368075;
	bh=sGV16EqAn7Hfxn4QOUApjglvBnUGAg7wZqTLZmyoqQY=;
	h=From:To:Subject:Date;
	b=SQ1rgpCPukibsLBXwgheYfgaYfWmMX7ehrshm++MrbHXZoXGlzIVQDdt57mV7KPIY
	 p9mmoqUj2iWW7ycyw53+kcn3i9TLDgy+OkVKWi2AEYrYLXoC9+LwfMNcQ68cgaY2SI
	 vFcFBgVD9f3YeNHIxfxpKkS4Wozbm3K44i2jHMdY=
Received: from ZYF-DESKTOP.localdomain ([112.64.102.79])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 32129A32; Sun, 01 Mar 2026 20:12:33 +0800
X-QQ-mid: xmsmtpt1772367153thnfcora8
Message-ID: <tencent_003DF0338EAB42F1573BC0CCFBEACE321E06@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIe7MOo7nId+jPtaDumFBzZaCC/4MmFDyIYHHFpRF4wERwuyVUWzM
	 ZOQ5Cwze3Eal/ks4VumWdA5vZ/TCC4fvV1QikgPkyt9gZoZNsdhNGkEvd3MVX1O130aQAFwMPWCW
	 3mc9va9VUJHsAS0PNhO87gZKnxJavFvR3fbwAXZd6dt9es5H53j4FoCSOqDMY84aXdaR5WNsor0S
	 uZpwrVdL8kU1hslZIWPUwVtuQKCbThFKHFYTzA6tbv4B/nDC9JS28tuJba8sU9C08SJ3OOELRnWC
	 yY1MSHe8p369M2repmaVLlze+zpW7HboUgZ4KhJCHGwpyCW3/jU1oc/mSBnE5k2AnTDYAJQslNsv
	 1N8F2uUk1fRrELE6n/3C7CjH0bmnAQlXsJXFzQtjQebo1JzQw8L5gD5KlnhZn3WjE/ZeblvYzFLx
	 1OaEVdLn63vzkSI1SgO3B8xEYWjl6GwFyL1l3Vt0mvXPOf4zBwWmwn3D+hfHjEjB6q6+eguNB3NM
	 mOHL0eBxGb3ynKLhOb/NYQAiUm88TD6wUrDRGNBG+PMxu0X/6uzihPW24XaCC8dgpUoKrK6DGBDn
	 ZzFB7cXY1qFXD5L5lOwF3BuqEOGMJuySvFchShvpp2RQUP4jtioiXks9RbULdBpuQdXdOuspRNFM
	 bZpQxjM4ieJcVHmRRZbTXMuhD1V1hSE+SLWs0Luhp1jn31YF1DXCrQ0S3RhOwbsh/0qqkDb7Gh5O
	 jWg17LryBd5cdKoIINf/p2u7CQYrddDHN/rDX4DvJjOxyYNPwoI5gRWTHFLPg5DHb0b/jemITHi2
	 saOJBV7Nv2ApLjF3dCVqYFjyZbtzkYlMZ3dIFGsb/iSEjpSRRcGlBbv7Bp6E/X4gczaZ/1bBwUOl
	 rQNr0SS2vAX6NAR7PcJCWFyNqzMipQsiSXxVkX7zhWmzlOmbATzGMtS7+iIAq31WCsvakccQEZVV
	 a+90FWvBDE9k0/UTck1fIEBnYEENOJULDzlxDvHg7ECPzXEAJNQGGcoWSLEv7lLF//8/Kw8pge4i
	 1He8nLWcs9lxbWuj4WBPzoVzqBWCWYnfOZ5BgF+RzVqTbnXI2+vu42dScf704MPUmm5+13fCfIuq
	 IxO2VpZ/+AmPcPMl4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Yifan Zhao <yifan.yfzhao@foxmail.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH v2] erofs-utils: mount: fix flag-clearing bug and missing error check in parse_flagopts
Date: Sun,  1 Mar 2026 20:12:33 +0800
X-OQ-MSGID: <20260301121233.185105-1-yifan.yfzhao@foxmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  0.0 RCVD_IN_MSPIKE_H3 RBL: Good reputation (+3)
	*      [162.62.58.216 listed in wl.mailspike.net]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [162.62.58.216 listed in list.dnswl.org]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [yifan.yfzhao(at)foxmail.com]
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  3.2 HELO_DYNAMIC_IPADDR Relay HELO'd using suspicious hostname (IP addr
	*      1)
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2447-lists,linux-erofs=lfdr.de];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yifan.yfzhao@foxmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.817];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4841B1CF962
X-Rspamd-Action: no action

The MS_* constants in glibc's <sys/mount.h> are defined as members of
an anonymous enum whose underlying type is unsigned int (because the
last member, MS_NOUSER, is initialised with '1U << 31').  Therefore
~MS_RDONLY, ~MS_NOSUID, etc. are unsigned int values that, when stored
into a 'long flags' field, undergo zero-extension, not sign-extension.
As a result every 'clearing' entry (rw, suid, dev, exec, async, atime,
diratime, norelatime, loud) produced a positive long, so the
opts[i].flags < 0 guard in erofsmount_parse_flagopts() was never true
and the corresponding flags were set rather than cleared.

Fix by casting the operand to long before applying bitwise-NOT,
ensuring the result is a negative long with the correct bit pattern.

Also add the missing return-value check for erofsmount_parse_flagopts()
in the '-o' option handler.

Reported-By: rorosen <76747196+rorosen@users.noreply.github.com>
Closes: https://github.com/NixOS/nixpkgs/issues/494653
Signed-off-By: Yifan Zhao <yifan.yfzhao@foxmail.com>
---
 mount/main.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index b04be5d..7c557bd 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -203,15 +203,15 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 	} opts[] = {
 		{"defaults", 0}, {"quiet", 0}, // NOPs
 		{"user", 0}, {"nouser", 0}, // checked in fstab, ignored in -o
-		{"ro", MS_RDONLY}, {"rw", ~MS_RDONLY},
-		{"nosuid", MS_NOSUID}, {"suid", ~MS_NOSUID},
-		{"nodev", MS_NODEV}, {"dev", ~MS_NODEV},
-		{"noexec", MS_NOEXEC}, {"exec", ~MS_NOEXEC},
-		{"sync", MS_SYNCHRONOUS}, {"async", ~MS_SYNCHRONOUS},
-		{"noatime", MS_NOATIME}, {"atime", ~MS_NOATIME},
-		{"norelatime", ~MS_RELATIME}, {"relatime", MS_RELATIME},
-		{"nodiratime", MS_NODIRATIME}, {"diratime", ~MS_NODIRATIME},
-		{"loud", ~MS_SILENT},
+		{"ro", MS_RDONLY}, {"rw", ~(long)MS_RDONLY},
+		{"nosuid", MS_NOSUID}, {"suid", ~(long)MS_NOSUID},
+		{"nodev", MS_NODEV}, {"dev", ~(long)MS_NODEV},
+		{"noexec", MS_NOEXEC}, {"exec", ~(long)MS_NOEXEC},
+		{"sync", MS_SYNCHRONOUS}, {"async", ~(long)MS_SYNCHRONOUS},
+		{"noatime", MS_NOATIME}, {"atime", ~(long)MS_NOATIME},
+		{"norelatime", ~(long)MS_RELATIME}, {"relatime", MS_RELATIME},
+		{"nodiratime", MS_NODIRATIME}, {"diratime", ~(long)MS_NODIRATIME},
+		{"loud", ~(long)MS_SILENT},
 		{"remount", MS_REMOUNT}, {"move", MS_MOVE},
 		// mand dirsync rec iversion strictatime
 	};
@@ -281,6 +281,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 		{0, 0, 0, 0},
 	};
 	char *dot;
+	long ret;
 	int opt;
 	int i;
 
@@ -305,9 +306,11 @@ static int erofsmount_parse_options(int argc, char **argv)
 			break;
 		case 'o':
 			mountcfg.full_options = optarg;
-			mountcfg.flags =
-				erofsmount_parse_flagopts(optarg, mountcfg.flags,
-							  &mountcfg.options);
+			ret = erofsmount_parse_flagopts(optarg, mountcfg.flags,
+								   &mountcfg.options);
+			if (ret < 0)
+				return (int)ret;
+			mountcfg.flags = ret;
 			break;
 		case 't':
 			dot = strchr(optarg, '.');
-- 
2.53.0


