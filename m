Return-Path: <linux-erofs+bounces-886-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CC3B326BF
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Aug 2025 06:02:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c83Kg5skZz3dBj;
	Sat, 23 Aug 2025 14:02:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755921735;
	cv=none; b=R3BvD2ir1tWIMyLr1Vzkb4GcEIiV1+DofkASwLB6okqmKCsc2bP51iIeKJnniLzuDSmaIIMDf/+adjRJUNiT2sXwWQkZ79KdFosl+6FxLOJBxtBdSfRXikyGofDGyPJ/sDk1jsNgH39eBC+GlycxCHuZf7hStDeRBI/HNNAEezhCL+h7bm4xOczueAy6pde5imyFuY84Br2hJq0XdH8pMaPcyPqy+l1RsLSwizSuucDIOJIbkod1AB/KLBLLo58VPvDdNuvyR9NnsSNeJIPtDNXmf0ls7invQ2d6Qv24K+ymbRO1SR0auP3k6AwlW+N7YU5osNaQptuG1sEvcymh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755921735; c=relaxed/relaxed;
	bh=Bhjbjl1XmoxFCl6VXorur+MFrEbFoojgEAGMZ1ax57s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=A9jb4XwPm11SwXddSKFyXcuuB6U3CU8dCR70RRuRzmGfgzSSrw/Yrggl2lAIi++YmbYj0s0at+g1g1t3Gxx+nrsozpKNXxnrk97G7cq7QY9E5QKd5WJ2ZDUPXQktYL5IKMW1xOMtdJmM1zLFV2Vjmx1czsLHMHPZ6QFxS/v7kwSXpoXxQgHOCRjll8nd+d2rEWjhdUb8v75GA3/SnhyfasgTRB1OCMJTbdChGLX7SQuJycjedMUkexi4d1E4i3tZfSn3EcSCaGaJ9TN/rcjkb4l9tOt1GtqJMMoh7atOpHtK2v+7loGLUZm9DB4b3Z+5vwv+5qvBJIhRX4MlMXB6Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=aghFsb7c; dkim-atps=neutral; spf=pass (client-ip=203.205.221.192; helo=out203-205-221-192.mail.qq.com; envelope-from=eadavis@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=aghFsb7c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.192; helo=out203-205-221-192.mail.qq.com; envelope-from=eadavis@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 6980 seconds by postgrey-1.37 at boromir; Sat, 23 Aug 2025 14:02:13 AEST
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4c83Kd4dLNz3clx
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 14:02:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755921725; bh=Bhjbjl1XmoxFCl6VXorur+MFrEbFoojgEAGMZ1ax57s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aghFsb7c32khcUbBv16Nxz3B5vsCpth/uNs3UPK2VEkKxsMlc/GCw7wbo88OId3OH
	 tIFdw+AcghOux3zF/bf+jmzAJf288XiXtZMjSqc5pb8C6Us7D/9xyoR7hacH1GOSOa
	 WA/hXFaTi3ti7IhjWLQ9E2ljZPI9S1m9L68b7nFY=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id D672C4D5; Sat, 23 Aug 2025 09:53:39 +0800
X-QQ-mid: xmsmtpt1755914019t8h8za9hz
Message-ID: <tencent_FC33559E331B7F4BA91BB62522BA1CBB8C08@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+tzJZf6CmQ1I2q0Y825byZF3DvrBFJIhOVc5ouQP6+VJNER27PP
	 oi68vvsQjBwiermXtCPR9wKCEwVn2a2WZrKEnRMgyn87wXVIB4bHq114WNfrbSZpkGBaU2M4tRsW
	 0ly3S/Ac1YCvEUYYGJRm20Cs1E4vvx6PQQ6DDoBjSKIBRzmQ0WXNqCtaoTGVgU07w8crvT1o8lMm
	 vwSonuCoTsXzlIT0mOada730a7Vx1KB7SNK6QEmJVqPEiebzLuS8UNTYrlO8M+ffw5+H194cBTdw
	 9Z/UTQSJFHbk4ZM9Q71zTuzQOH1HrnQcf6+05lDvmTuzmX+WC9kxspc4QrbWAQujrwBV5JS0De3f
	 Ry1LJ7/RxpmLr0XqVnj/yzTWzbcnp3Py8/S26sXYVPImfhU2Uxa6BYzN7QCXIBWpX0Ve6MR4qVnV
	 tptToGhHXWd6dOWUsdW8kJRYETWwubb9o4rEgwcU5YkjCOTvQfvmG7l0FdydvA51wV/ovGI6TW+S
	 6YRZpCqWk7sI7F3HPpiNPgJTtE6o3XgSAv72gxYKxWublM8aVw0lsbzC7IB6z8YXe9gg1Fm43KnZ
	 kAkTn5g6OoJXAM/AxbuPF1g3ug6bp6n+QeQHV/sUMoMTB87QidzPOTnktEhhBRWKA8tQi0UnaS0+
	 7HJnGASig8YukwlO2J9s1fOJcRKFPjyBCy+y5hFl9Bp1SksaRrsT4LGRentnAl1ad8B/Y0zGft9W
	 r5Yns8S2VlgHhVvMKqQnMXBi0Za0eMQZfZfPY7XrZI46GtVZND1Lo6OJ6H3Yxtq6DiutT/hVKLGc
	 3laPdCZ04IwgBSdpK+V8AC9PvBqyv2O34NQhlHJtgtc6jff1v0OHm4wE+guPe3c2bNbdKUsMONHB
	 7iKLK0oV3j3UCWHySAH14jpf/Zf3DXOoPa4xPo/dmZhjc9sF1UXUhopclXaKCD6SCgQneYsx6OPX
	 mHRvtPWo5KnjW3q03TKnKS171tWU5Vk4vAAZBauII2SBrzPleSBToEwfo0Ub+22whh41M2xIPlRw
	 Wgv+qKMg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Cc: chao@kernel.org,
	dhavale@google.com,
	jefflexu@linux.alibaba.com,
	lihongbo22@huawei.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	xiang@kernel.org,
	zbestahu@gmail.com
Subject: [PATCH] erofs: Prohibit access to excessive algorithmformat
Date: Sat, 23 Aug 2025 09:53:37 +0800
X-OQ-MSGID: <20250823015336.2652882-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
References: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
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
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [eadavis(at)qq.com]
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  3.2 HELO_DYNAMIC_IPADDR Relay HELO'd using suspicious hostname (IP addr
	*      1)
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [203.205.221.192 listed in list.dnswl.org]
	*  0.0 RCVD_IN_MSPIKE_H4 RBL: Very Good reputation (+4)
	*      [203.205.221.192 listed in wl.mailspike.net]
	*  0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

syz reported a global-out-of-bounds Read in z_erofs_decompress_queue.

OOB occurs in z_erofs_decompress_queue() because algorithmformat is too
large.

Added relevant checks when registering pcluster.

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
Tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/erofs/zdata.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2d73297003d2..085fa0685a57 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -762,6 +762,10 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 	pcl->from_meta = map->m_flags & EROFS_MAP_META;
 	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
+	if (pcl->algorithmformat >= Z_EROFS_COMPRESSION_MAX) {
+		err = -EINVAL;
+		goto out;
+	}
 	/*
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
@@ -796,6 +800,7 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 
 err_out:
 	mutex_unlock(&pcl->lock);
+out:
 	z_erofs_free_pcluster(pcl);
 	return err;
 }
-- 
2.43.0


