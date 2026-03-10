Return-Path: <linux-erofs+bounces-2577-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJb6FS0IsGkTewIAu9opvQ
	(envelope-from <linux-erofs+bounces-2577-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:01:49 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F5824C1B3
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:01:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVXXk05qfz3cCx;
	Tue, 10 Mar 2026 23:01:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:bf0:244:244::119"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773144085;
	cv=none; b=bYSdZM382ofRESH2Nic1w1Vng+hmEryFLu8PSznHZVo/pA1lhZZakfY07yCdFHckJLWtU3jGs3McYMASuROMUVdLZ2jYLAciJjZ+D25dCtyEjmYxIf3fkq/+jTz6pLbU19EGkpV3AT5jiJ/t6IlYoEbXhkyvBS67nznkdVZIAyyRpDTwJfVYdi35rVUXmTrl/mJf/FrD3FVuO5aX9RohZkKas8AmzZDbY7h4EYxdcxGx7LO6T/HYQCfmwvFvK97xYMPcA6UzWILtUtYu6KVZeZxY7eAxjywpsd0I1LWFzVL3VOcLv5n645ATQMZsOS9vvOFnRBwkADSdvznAjSe2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773144085; c=relaxed/relaxed;
	bh=JeJj0T69WHUPLsIPvgVGO/TfjBqV2iFp2koKUN8LMcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aql89bJOALs4xtKxjmgFiq3YJSy7I8NzLa/SxMEzImerbGDHtuWxtrCHAPwieoS+JUZ6JMdbJF9dbzdiRJuoWuiJtwfzgWI4SqBCWzcLSQABSIke7D5B37/MygB9B8ixNRHcCSulhFLiNo0encXlPKJNyhCPiRTPr3+P9kF63xps8Ld+z8tjfr/pai7zt6knL/GbLM6Ay1aK2PMx153Q7joW3zTIF7kxrrI+Al9/rLG+02GlwxBTYBYgHhSuFXhU2df4sQ4Z/g2IH2xndaPtzkzCtgIqd0KkQGaTaXLjQdNmQDLU/f0Mcp1VpjpdKORL3bM0PZB8bTc/HJm2+R6Lcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=QeZmxS4Y; dkim-atps=neutral; spf=pass (client-ip=2001:bf0:244:244::119; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org) smtp.mailfrom=avm.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=QeZmxS4Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=avm.de (client-ip=2001:bf0:244:244::119; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org)
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVXXg1bKyz3cD1
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 23:01:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143726; bh=w6c4PA3VGZ44yyLt8mghr+WTJ9TxkFa/GQpFHp0jaRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QeZmxS4Y9ZxzJ1P+c7PyBalRHGdguYBtzjQZ1WHuqnNfndJHBOWadzXneNpIO/Cpe
	 WtbDE01JXbjsGwDZW/SJl+0F8SgXDtITpS9jrWOZKuA2MxhvXL4esHAjK0cxyNxT8g
	 cX9nlCS2vI2XLhpV0lZEIvKvUcBSNRY+QxXEviZg=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ad-2367-7f0000032729-7f0000019da4-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:25 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:25 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:56 +0100
Subject: [PATCH 30/61] net/sunrpc: Prefer IS_ERR_OR_NULL over manual NULL
 check
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
Message-Id: <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=w6c4PA3VGZ44yyLt8mghr+WTJ9TxkFa/GQpFHp0jaRg=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAY7O6x5f/jrEOlM2kM2YjYC7Xq22wW3Mikry
 9AY9ISieLCJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGOwAKCRA0LQZT0ays
 24W7CACaVIegavbFPh1+6gPSjqv5T1Ou5hQU0OcaZ20nx5fdOimad+jK3UuGfZrC9Vgv0QMm0ym
 3OSuSluEWbuIv6zcFp3UbdEj9aI7TM7en4Ha7pCkmDfNfPts09fhhi9VrPo390VGOMeNWeVMtD/
 CQde1U2q7DKI3QtGXyjY9I//uCPpAfeRw/e0X1QSKZ9eOdV+c4uWgQhNCPrPJZrHvycJx2lFn3Q
 ZNRGEplISNXY/bb/iuclRgqFYvGWnoUgBYQkpTrGJqDvFREwT8LcHN3+0nwKoz0xIqQbO7gBWgt
 +Dgbc3vk23keeP8aHFv6AZ7K16GCQyMm+zwDBr92eUq+pHvN
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143725-8A498E1F-7900509A/0/0
X-purgate-type: clean
X-purgate-size: 2553
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 58F5824C1B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2577-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[67];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,oracle.com:email,avm.de:dkim,avm.de:email,avm.de:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,brown.name:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
To: Olga Kornievskaia <okorniev@redhat.com>
To: Dai Ngo <Dai.Ngo@oracle.com>
To: Tom Talpey <tom@talpey.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9b623849723ed0eb74b827881c6f32d3434c891b..b4d03e59a8202f20360cff1e2e79b1e325396517 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -578,7 +578,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
  errout:
 	/* Take a reference in case the DTO handler runs */
 	svc_xprt_get(&newxprt->sc_xprt);
-	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
+	if (!IS_ERR_OR_NULL(newxprt->sc_qp))
 		ib_destroy_qp(newxprt->sc_qp);
 	rdma_destroy_id(newxprt->sc_cm_id);
 	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
@@ -608,7 +608,7 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	might_sleep();
 
 	/* This blocks until the Completion Queues are empty */
-	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
+	if (!IS_ERR_OR_NULL(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
 	flush_workqueue(svcrdma_wq);
 
@@ -619,16 +619,16 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	svc_rdma_recv_ctxts_destroy(rdma);
 
 	/* Destroy the QP if present (not a listener) */
-	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
+	if (!IS_ERR_OR_NULL(rdma->sc_qp))
 		ib_destroy_qp(rdma->sc_qp);
 
-	if (rdma->sc_sq_cq && !IS_ERR(rdma->sc_sq_cq))
+	if (!IS_ERR_OR_NULL(rdma->sc_sq_cq))
 		ib_free_cq(rdma->sc_sq_cq);
 
-	if (rdma->sc_rq_cq && !IS_ERR(rdma->sc_rq_cq))
+	if (!IS_ERR_OR_NULL(rdma->sc_rq_cq))
 		ib_free_cq(rdma->sc_rq_cq);
 
-	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
+	if (!IS_ERR_OR_NULL(rdma->sc_pd))
 		ib_dealloc_pd(rdma->sc_pd);
 
 	/* Destroy the CM ID */

-- 
2.43.0


