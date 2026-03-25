Return-Path: <linux-erofs+bounces-2987-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE8UElqkw2lssQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2987-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 10:01:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D59321CC3
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 10:01:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fggqc2MCtz2xcB;
	Wed, 25 Mar 2026 20:01:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774429260;
	cv=none; b=L46pvOO+HmjDmlF1X1lfLSESnCzjhflAn4Gqr1wajyN77IyQfxuotgOdCQk6kxngV5mag8v75kO8ZP1OcrXWN0yofJQQ9yl80E2rsYdQMh0ayYv8YQGxPeDNkyKChQmR9MtsobpcoXpH96pwUGXrtCoTBawKRyVfi0yvz2PtqVSAsdNTLPW7l5pVi3vGFg5ad5Qx5eTbituDw6Vh1K8MqgLX1V+f0QMlw7aFhIeEXjjeYGOyh128eskeFkp01ikrjW7gJe1xcTWJCUieBwpTgclHpe3lvbsJmtOtZuzWOA0HgTWrkuqplePjGpLoKLkot2szL5qS+1cmABWD5yRzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774429260; c=relaxed/relaxed;
	bh=w+nLUZgwSWMrVsQ9BWc8IL6TNoSizs7cHzH744u3HYw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PI9CeFBx3ngIPbZX2KkFvcRqM+hmDVD068agMX9YNNrmXANYEzRN7KT+RNeTGi7fy8omz/0gMgfjMsGExRQMiVI7ZoztiawNoVwzhXr8Ox+571flgHSb7YXIAu5U52Z1++gaho18ah7Xzt8lnUGlzbmzjM+Bnr8AYgSBm8iQW+kUMBRbqqNSodscFJk0PNe+7VDi7gje4OYxcIA/qsTybUq2IqG97sdE5791c3soP/j67eweB4q/TRhOVxNexMMz+/5q/A5EmdX/vq0U30XJal1F0jHsQu3AatxN0j5itnKiRPEmzYaCeIpPfNktPBAK90oRi0XE9TK0efjvzB/OnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qcgFNxVG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qcgFNxVG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fggqZ3DXxz2xPL
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 20:00:57 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774429251; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=w+nLUZgwSWMrVsQ9BWc8IL6TNoSizs7cHzH744u3HYw=;
	b=qcgFNxVGHun9fQws7HocMyDDuiQH0kRH9GDftLB2lT4T4sCctnWt5GVL2ZSdNo5hC7YQl+vpAIxGXghmWQ2nVa2oHDwPkEcg92FB4+yLBW+YL7mHji+cuVuKjr+cKxLXd/b4ViedFIZrA8vJJGLd19OwSEScsEK5P/oguLeRDtg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.hGmRK_1774429248;
Received: from 30.221.132.80(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.hGmRK_1774429248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Mar 2026 17:00:49 +0800
Message-ID: <8bed2474-4e2c-4a28-a959-bce3bc5190fb@linux.alibaba.com>
Date: Wed, 25 Mar 2026 17:00:48 +0800
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
User-Agent: Mozilla Thunderbird
To: syzkaller-lts-bugs@googlegroups.com
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com
Reply-To: 6855f07b.a00a0220.137b3.005a.GAE@google.com
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [v6.6] BUG: Bad page state in z_erofs_do_read_page
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-8.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:syzkaller-lts-bugs@googlegroups.com,m:linux-erofs@lists.ozlabs.org,m:syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-2987-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linux.alibaba.com:query timed out];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[lists.ozlabs.org:server fail,linux.alibaba.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	HAS_REPLYTO(0.00)[6855f07b.a00a0220.137b3.005a.GAE@google.com];
	TAGGED_RCPT(0.00)[linux-erofs,b6353e35ae2bab997538];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[6855f07b.a00a0220.137b3.005a.gae.google.com:query timed out];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 15D59321CC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

#syz test

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c1f802ecc47b..e744717d6003 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1538,6 +1538,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
  	}
  	unlock_page(page);
  	put_page(page);
+	/* since pcl->compressed_bvecs[nr].page has changed above */
+	oldpage = page;
  out_allocpage:
  	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
  	if (oldpage != cmpxchg(&pcl->compressed_bvecs[nr].page,

