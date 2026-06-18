Return-Path: <linux-erofs+bounces-3672-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FCaxBzTIM2rbGAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3672-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 12:28:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AF069F4EC
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 12:28:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=bPHXN7C+;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3672-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3672-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggxkk3VPsz2yRF;
	Thu, 18 Jun 2026 20:27:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781778478;
	cv=none; b=oUJ/2rI5kDw/jffwXYlJmhYFZA3HpnkhXzgxKk/k/kBktRb+fVyd4aPf2dFRDK4KMQwfc76XDQ9lK0tDzM14NCnCTDm0pIvHiytQOBplwVfULlzvI4tr0dRZGdN+QusS2aIlzPOlY8I1prvWxdpLGZrKWU3wRwQAqRi1SBeXkEFJ4paBCf8y7+WxyeoicCNooC3hWahkx2K1Z+r3ifhBmF8MOtihr1ZzCboVi7rF1gj4obBUEbOsfjBNVBLjHA2SPaVrrtlTyJBeaUSBjr8SZR1qhHvslB3NIQZju+OEUkwAIY2xmtrN24sxl9+ketbbKx2Fcbkt6W5Bvtun/f4suA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781778478; c=relaxed/relaxed;
	bh=MqBGkk6wcSdrc1kSrODb8jDMwhC8Pa/nfcjc2VhB0y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R03tOM9XxG5pnbQdFx68iPFIlYHxSbU44EGk2AEsX12pRVO01TKCD5wikosx5Uras3EDdFRGjfJYjR8rHC0cas52nI35Bv15uWEVEJdpI8VVuIQeexU2Z5tnYhR59yqiAk7K6isvfT7BGb35O7w0qpR38zMnJNVrGgPwQwg5QGPk9M1+/G4xytcmUKZX17KK5viKiUWnVY3hLsjhTPoY08Xn8WUCMLLniikB+9tK5oH0oBi46uNnZZBdg4XmSJw0bKkHDb5SsJ1QlKv9zbUyaxhoyp2qp43yMFKifcnuKdxNqHOaall+nFmVENHILWFJ4DtTUKssNgYJSHqiJhxzbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bPHXN7C+; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+d0115506b4e64763d629+8334+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggxkh3NXTz2xM7
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2026 20:27:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MqBGkk6wcSdrc1kSrODb8jDMwhC8Pa/nfcjc2VhB0y4=; b=bPHXN7C+YXigi+F6P6JvV90i+r
	XOjKWBv/hissgNpqsqcfL76SFwxKQnft2HYEGoIFWlc0gi6AwEbUV6R61M87exV40xAKJUfOhwFgx
	yxAy9GsE8NJLaXMK8tbm7zkOC0lnbQQTlAc+w+lphGp9fUCTRlYSHsVLlvc5UoaBs8SwFC42xL8J3
	VV+p9ihxB5I9FiZt1W04ZJZgybkwLAncAzprmG9MXP1D2lbntdt4o6TQIK/bWEgsXUJJtUEsgXCfb
	OR9FmG0HdKH6Pj6oTrGDrQa9I7QNaqmwJq1pv5o1Hpwuyif/zWkzGzuIhV8N7dKUJJpSTGXVmZ+Lr
	+wNatRuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa9yL-000000016Nj-3qaH;
	Thu, 18 Jun 2026 10:27:45 +0000
Date: Thu, 18 Jun 2026 03:27:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"zhaoyifan (H)" <zhaoyifan28@huawei.com>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yekelu1@huawei.com, jingrui@huawei.com, zhukeqian1@huawei.com,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: don't merge bios over iomap boundaries, was: Re: [PATCH] erofs:
 prevent buffered read bio merges across device chunks
Message-ID: <ajPIIU1JB9e0ksBt@infradead.org>
References: <20260612033244.993507-1-zhaoyifan28@huawei.com>
 <58bef9af-0926-4948-b917-e38c3793f596@linux.alibaba.com>
 <aiumQL8LEWQX_Nag@infradead.org>
 <fbc281ab-09ba-4e3a-90cd-2babc708fdc4@huawei.com>
 <ajOzy2NPD2GlXcNt@infradead.org>
 <7a38b823-59f3-419e-9070-cbc848f6f1fe@linux.alibaba.com>
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
In-Reply-To: <7a38b823-59f3-419e-9070-cbc848f6f1fe@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3672-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:hch@infradead.org,m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:yekelu1@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:ritesh.list@gmail.com,m:djwong@kernel.org,m:linux-xfs@vger.kernel.org,m:joannelkoong@gmail.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[infradead.org,huawei.com,lists.ozlabs.org,vger.kernel.org,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9AF069F4EC

On Thu, Jun 18, 2026 at 06:14:03PM +0800, Gao Xiang wrote:
> I think this patch can go alone seperately because the
> correctness is okay and cross-subsystem git merge is
> a bit of churn.
> 
> I've pushed an chunk merging patch individually to -next
> for this cycle too, and it should fix too many bios issue,
> but even without that patch it won't impact the correctness
> (just less performant.) I assume both patches will upstream
> in the near future.

Thanks.  I'll get this patch dusted up for a formal submission in a bit
and will send it out.


