Return-Path: <linux-erofs+bounces-3822-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gXzqJA5iS2r/QQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3822-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 10:06:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D3270DE6A
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 10:06:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=envs.net header.s=modoboa header.b=K3fkFcXT;
	dmarc=pass (policy=quarantine) header.from=envs.net;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3822-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3822-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtxlH1lGCz3bps;
	Mon, 06 Jul 2026 18:06:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783325195;
	cv=none; b=G+BBC5FDR0JBH4BFS4q2YnNO2ILDpZ6aELLhudUYcQRNrWU3UwuVzw2Pp5Dm4DPUeL7OVu57O6wq5B/P5QkiXQAiZZa/A3XkfcWLtZXk7pCweikbRHewKuxIs5Q7w/XLtQe9Vcs1uveutWaW8KmAMJqVcaRtrVQ/qRSh5QQa9BMo+BeH/GGThmwaMgLz20Dwk9k9FHx3EaFpMFopS27kr5vvxZTjLGT2rpP0n5OdzKrccm9ZgCktHc0khCDiyvaq7kDu+FSHi4SRw6u35fwCDeKbp7ElWTlEJssFQNPuuccYoiwHYB8XLrWkyHKwPTJXhI9wD4zQtGPU8ej4P7z+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783325195; c=relaxed/relaxed;
	bh=Ca3qkNHic8rR3X/AP7JbZLGtPa++G6cubzXyiDrZHTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k4+tCHXEphSpMN7x8l5xS2NvQtN799rCU77kMspFpqEq1rfJ9YgNQhTz/V9st4zxzpIUVRnIlAzx/Hqt1nRk7EZbs/lnX4Gn5IT0dPiRws02WlWK/20AincNgCFssXdzldDNeik4bQzrwQUgXtQaApmR0YWRvNZ3qr/Q5YaqBLhhEIeoU0M5X7hA6frNZZHPLFT1pUQ9ygdXN7xZSc67/qmAYDjVDS2T65WnP1BM2ikqftcIpDzf15gyYgCfOrfBywY8OBRueCaSMIzmKgW/yJrrCI0is1UbFY1UnkbxCZujLHKT9bffFzOiUHQWxjN5OKXjEAKuTS+uP/fRP60/Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; dkim=pass (4096-bit key; secure) header.d=envs.net header.i=@envs.net header.a=rsa-sha256 header.s=modoboa header.b=K3fkFcXT; dkim-atps=neutral; spf=pass (client-ip=157.180.15.194; helo=mail.envs.net; envelope-from=xtex@envs.net; receiver=lists.ozlabs.org) smtp.mailfrom=envs.net
X-Greylist: delayed 401 seconds by postgrey-1.37 at boromir; Mon, 06 Jul 2026 18:06:32 AEST
Received: from mail.envs.net (mail.envs.net [157.180.15.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtxlD1rXpz3bp7
	for <linux-erofs@lists.ozlabs.org>; Mon, 06 Jul 2026 18:06:32 +1000 (AEST)
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 79F561C00C5;
	Mon,  6 Jul 2026 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1783324786; bh=Ca3qkNHic8rR3X/AP7JbZLGtPa++G6cubzXyiDrZHTQ=;
	h=From:Date:Subject:To:Cc:From;
	b=K3fkFcXTmWAtZpSzkntrcpMQFAZBx34Ryl4GBXh+I8ofkkf9L4OFOtCd+C3kJtcGD
	 ffzP6VIbTrFk+hiCgGrQK2UhA18pTLAlOmSBCeLJN/wiuOCWHU/CXkSZtWBk4UmLgS
	 mx97XK9isjFgpvUGEZwhxjam6z8f6AuU7Zgk8oaFcYNGzw/vVGaSis0D0YNUvjMLQO
	 uQIcpCH0pVBsVAl3uN6NW9ph+gC5pp/ipYNCOgaYWqFY8HLWeXCMjyDYzWEWl9MZHz
	 DkaOK18YhL6R3/xJp5J/62dln07JtcaD+scBB29rI+awbo1NdP3dOfH+pmJh0R0RWG
	 68VtGsOR4bobxoTw46WdqzPvZ/E1jcpBYtbKjTg1EoUGG9bVO5oXJtMtJ87JM0+/UA
	 UXHvrZQKB4FrWk0uE1IYPACyhURCtpy9yCTi2BVP6e+/wa2+Ubb98htXMeksbM4ayb
	 JZ8K+hcQEVYZsMK5OycSzHo98LKSPuv4xAoBidXBcONhY1xEclHv699zkKktNmjZRN
	 h72CQMn703xugWQFjnz4EG/XlcxAElnv5pNzW9HP7NRNyRHIYMJMLT130iqvbBR0ei
	 aFk+iivogBAbK2l7G7vuLCEwawYr98EeDKQZV7OteT88hBOcXrmmNnPqc5x2VzJzIa
	 iRDMddZSNZu89B4KmKT1vit0=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A2ZTFu_HqxWi; Mon,  6 Jul 2026 07:59:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [120.239.111.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Mon,  6 Jul 2026 07:59:44 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
Date: Mon, 06 Jul 2026 15:59:17 +0800
Subject: [PATCH] erofs-utils: lib: fix memory leak in erofs_fragment_commit
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-frag-leak-v1-1-ffcb9d0c983c@astrafall.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE3SdtGKq4hF1ZRBkBaRiLsrl
 l/y3n9BpMAUocwuCHRw5GVOkHkGrrdzR8htMiihtDBCo+cTfbAdTmRH9MZq56VRUheQPmugNPh
 6Vf077s1AbnsjcN8Pn84ZonEAAAA=
X-Change-ID: 20260706-fix-frag-leak-f7a6cf172168
To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs <linux-erofs@lists.ozlabs.org>, 
 Bingwu Zhang <xtex@astrafall.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1783324784; l=2681;
 i=xtex@astrafall.org; h=from:subject:message-id;
 bh=vR2c6MjTR1daO06vJStSVsbim6Z7UuAtZZwm4AE4sNw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgL1erbbl1jNM9AtzeLFJ5FKVqr/ylJ
 MBUj5+W9IwwCl4AAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGXCpcBU8QEL+ovTG+VmNndTAya7axQVpD/exEBNPjjhA0tiOR9z3K2WkNFofO4SezmeDFbwJ4E
 /qyWNcOr4kw8=
X-Developer-Key: i=xtex@astrafall.org; a=openssh;
 fpr=SHA256:IEYEjkZlkUTr5U9GiDAmZU/4eZus2t2RsxusyhQqwao
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[envs.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[envs.net:s=modoboa];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:xtex@astrafall.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3822-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[xtex@envs.net,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xtex@envs.net,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[envs.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[envs.net:from_mime,envs.net:dkim,astrafall.org:mid,astrafall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6D3270DE6A

From: Bingwu Zhang <xtex@astrafall.org>

erofs_fragment_pack may initialize fi->list as a
new list head instead of adding it to a bucket.
If fi->pos is non-zero, the fragmentitem and
data buffer is not released by erofs_fragment_commit,
leading to a memory leak.

Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
---
Reproducer:
mkfs.erofs -d9 -Eztailpacking -Einline_data \
	-Efragments -zzstd --zD data.erofs data

Direct leak of 5080 byte(s) in 127 object(s) allocated from:
    #0 0x559bf549b788 in malloc (/home/xtex/src/erofs/erofs-utils/mkfs/mkfs.erofs+0x10f788)
    #1 0x559bf554391e in erofs_fragment_pack /home/xtex/src/erofs/erofs-utils/lib/fragments.c:205:7
    #2 0x559bf554426a in erofs_pack_file_from_fd /home/xtex/src/erofs/erofs-utils/lib/fragments.c:302:7
    #3 0x559bf552e89f in erofs_write_compress_dir /home/xtex/src/erofs/erofs-utils/lib/compress.c:2074:8
    #4 0x559bf5507421 in erofs_write_dir_file /home/xtex/src/erofs/erofs-utils/lib/inode.c:744:9
    #5 0x559bf5507421 in erofs_mkfs_jobfn /home/xtex/src/erofs/erofs-utils/lib/inode.c:1654:9
    #6 0x559bf5507421 in z_erofs_mt_dfops_worker /home/xtex/src/erofs/erofs-utils/lib/inode.c:1723:9
    #7 0x559bf5498fca in asan_thread_start(void*) asan_interceptors.cpp.o

Indirect leak of 7135 byte(s) in 127 object(s) allocated from:
    #0 0x559bf549b788 in malloc (/home/xtex/src/erofs/erofs-utils/mkfs/mkfs.erofs+0x10f788)
    #1 0x559bf55439c5 in erofs_fragment_pack /home/xtex/src/erofs/erofs-utils/lib/fragments.c:218:13
    #2 0x559bf554426a in erofs_pack_file_from_fd /home/xtex/src/erofs/erofs-utils/lib/fragments.c:302:7
    #3 0x559bf552e89f in erofs_write_compress_dir /home/xtex/src/erofs/erofs-utils/lib/compress.c:2074:8
    #4 0x559bf5507421 in erofs_write_dir_file /home/xtex/src/erofs/erofs-utils/lib/inode.c:744:9
    #5 0x559bf5507421 in erofs_mkfs_jobfn /home/xtex/src/erofs/erofs-utils/lib/inode.c:1654:9
    #6 0x559bf5507421 in z_erofs_mt_dfops_worker /home/xtex/src/erofs/erofs-utils/lib/inode.c:1723:9
    #7 0x559bf5498fca in asan_thread_start(void*) asan_interceptors.cpp.o
---
 lib/fragments.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/fragments.c b/lib/fragments.c
index 13afce3be537..f137e41b7365 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -325,6 +325,10 @@ int erofs_fragment_commit(struct erofs_inode *inode, u32 tofh)
 
 	if (fi->pos) {
 		inode->fragmentoff = fi->pos - len;
+		if (list_empty(&fi->list)) {
+			free(fi->data);
+			free(fi);
+		}
 		return 0;
 	}
 

---
base-commit: 30711d4b2e234fe3e8aaeb779ade4cb609b0d920
change-id: 20260706-fix-frag-leak-f7a6cf172168

Best regards,
--  
Bingwu Zhang <xtex@astrafall.org>


