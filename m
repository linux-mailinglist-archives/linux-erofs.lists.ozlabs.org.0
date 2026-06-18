Return-Path: <linux-erofs+bounces-3670-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nmEqBu+zM2oMFQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3670-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 11:01:35 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901269EACF
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 11:01:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=p4iXdViK;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3670-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3670-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggvpl0tR1z2yNn;
	Thu, 18 Jun 2026 19:01:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781773279;
	cv=none; b=PLBP8Qy/maq0irPcPKkOXypMWYthgvusIR9qodQ2PoimhztY5gjxLZxPMtgJZ+CsUo9cU/stTbf5xuHdV/BXsJ8CK/VHwWv7LPpT9UBLmuSuD5ea7Ug3yK0QVbHXP/YvOxKPdJ+InDVhvXcdmbLvRRvrpOAAOswW+qTMAQ1T5T7nqmFog4yoKhvqDSoykYywheN4eYP+/UVoovxp5mqGFuYlxtmeiM228qTpxgP/l9hviZ2MEaLXVbH9f0j7TdDBQBY4PtcNyo8XLo610KuUN5Tq3WM0uzzNTrE6fxY3hudxyl9uP4aMlzTdv0bB1x1gNw8w9NuXLeIAe46sXjZrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781773279; c=relaxed/relaxed;
	bh=M9EeFcKrsMF7BhoQjCI346X+ZOMEwg/R7gAke80GfVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAm+ChkO+dl/CRNdlcCMjq7aZqTK1BSCZWZYdPhV4QdJT+E8OGpDwZUZ7MlFVwddRwfz5AdXH/ZTpOuiWxVb78tlLu3coNe1lmNQvnWbVdqYozQJid83xsizKRy7d7C0z65soy+4fPVFKdIByWbL0c7buEvVtj1leAnNGoLb5vBPpbhriAHsoi/3WS73qaKuwO+dj8A8az9plipPwFW9lIU0huI6sS5vKgEd8hK2qyTfLvAytERr+LC06Rt3L7vznAlxsili0I426yqEFFTtNYEsHRnaN7/zyubk2fF/9U28xZo04OZcL8tQ4rmEpb5TIHxRmQ1u420XIpieC2H2Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p4iXdViK; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+d0115506b4e64763d629+8334+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggvpY0gtYz2xLm
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2026 19:01:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M9EeFcKrsMF7BhoQjCI346X+ZOMEwg/R7gAke80GfVI=; b=p4iXdViKvbqf6kRpw/cqG3Blwa
	6C1K9QAX6RilcSbbtwmuX/qVu/9ZC9qD2CbGR4GsoseTTprHtyPVWYUdF+WPaqcRq5No3aOVj4snF
	KgeBky4jqCsXBD7v5nK98j+u8QXMs0Lez/NEW46AB9BlZv3yxgLXldXr7403y3TEbMHfu+fk4wrP8
	oNE7wt85e0cz6qBBc0PJErX39MXQf5zHOibI1B73aiixUJYiknhsaDSLiL3IlMJlaOygj8cqZQr+q
	MWNvdmn9CVpEGytH/VmlAj16AgLGAvl2huoX9KpHS3adF+lzg6Lz+2ELB899KUxAivCV6cF1zjcG1
	NdUtNW7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa8cN-00000000t9z-0HKT;
	Thu, 18 Jun 2026 09:00:59 +0000
Date: Thu, 18 Jun 2026 02:00:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yekelu1@huawei.com, jingrui@huawei.com, zhukeqian1@huawei.com,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: don't merge bios over iomap boundaries, was: Re: [PATCH] erofs:
 prevent buffered read bio merges across device chunks
Message-ID: <ajOzy2NPD2GlXcNt@infradead.org>
References: <20260612033244.993507-1-zhaoyifan28@huawei.com>
 <58bef9af-0926-4948-b917-e38c3793f596@linux.alibaba.com>
 <aiumQL8LEWQX_Nag@infradead.org>
 <fbc281ab-09ba-4e3a-90cd-2babc708fdc4@huawei.com>
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
In-Reply-To: <fbc281ab-09ba-4e3a-90cd-2babc708fdc4@huawei.com>
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
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:hch@infradead.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:yekelu1@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:ritesh.list@gmail.com,m:djwong@kernel.org,m:linux-xfs@vger.kernel.org,m:joannelkoong@gmail.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[lists.ozlabs.org:query timed out,infradead.org:query timed out];
	TAGGED_FROM(0.00)[bounces-3670-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.1.f.9.b.1.2.0.0.4.9.4.0.4.2.asn6.rspamd.com:query timed out];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[infradead.org,linux.alibaba.com,lists.ozlabs.org,vger.kernel.org,huawei.com,gmail.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8901269EACF

On Thu, Jun 18, 2026 at 03:16:03PM +0800, zhaoyifan (H) wrote:
> Hi Christoph,
> 
> 
> This patch works well under my workload (at least correctness-wise). Thanks.

Thanks.

Gao, do we need any erofs updates to go along with this to not regress
behavior where it would have merged before?


