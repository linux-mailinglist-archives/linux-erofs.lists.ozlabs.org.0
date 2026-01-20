Return-Path: <linux-erofs+bounces-2090-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCeaKxOhb2ntCgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2090-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 16:36:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDB4637D
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 16:36:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwT4C53n8z3btf;
	Wed, 21 Jan 2026 00:40:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768916459;
	cv=none; b=fuXuxA4egQ5Wxv8Onl1IuX55dTjVC/pv0DDJNjVSqr/xfLMMz2Dcs/Zx2upJJ8Dyo6gs2b4Ry+fyuO6NIZcfNCTr5nDRnAMSRMEKeSGZx7tOIgGNwmXQOsM2g+HTcbt0F9Jx0WumtHpzV4zirDFXamql0C/MnQoPXXtZAZuMYFtA0AwtkxOuv8RRHihJbv99EI/++QHPM9g1GBqSPLtYF4YzasraLPXZ7bLUNLY2CXklkzobaMBfk9YNCNOvvyKl3CZPDrkXlEqmk7qsCBfkfN7I69iIffQfWhLCu00SiX3Id1zNeok2vTUxkwNm2ywacvzRI9NMNwEKHkHzDzhH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768916459; c=relaxed/relaxed;
	bh=lw+CGgxk+AVw2sluoSNTB0VP08ReIzXiG/Xbuv18LDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ4UXlsBzG0so1X3ARtWGluCf7DyayhSldg8H++r68DzYDmgXJcePsVOnYVenNMR7qS/ZwuZEZT1W1WZscNPDa2fVSBsJeM1YRc/lJwbOuEzx4B8PXwXYnEAuXlvFJSnld0KxaprJef8JXDr2owM/UPD5780DBJDA7hwoyH3GOmxLK2zArpPBL+D5/DCjgEtIjyJrZJjbOqgZPSgYCxgX2nJWINdSQ6F9hxGeGKYaC6MGRVPMABMh4kpLxUozPLVaJkrSEwIo6FuSxMR05xMqGk7GIt3mVsA449qlVwh8TK3++8EFLEyNUE6zRydJalrhJXGtZFeoJ+5tXlky4LIoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IgaYm6RF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IgaYm6RF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwT4B6kpLz3bmM
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 00:40:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 43B7B43552;
	Tue, 20 Jan 2026 13:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E950C16AAE;
	Tue, 20 Jan 2026 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768916456;
	bh=Ww2vxfC7ZENAqiEwBP0gWFkYN0X8gY0coLCd/8tmAYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgaYm6RFfv8Nv1drQJ6ITXMxHwPX49R+TMVL22Q6Xyi7XsPox85wvP3cDsYLvkgHv
	 01z5GLkgSrOEMm0sxBTDsWkRPGhnKRkEj74rWtV3eu74uyZ7IC4ZrvLZbIU5zIjtGQ
	 DWteKGqT4O52aDMm0GE0kgrPR7uVoFX/5G3OF44t3hgqeqNgNc05XNWC8yKXcFjD/Z
	 FOtoQ3WRbFJOW0ORiZSc3uQGRWPtwGFbY+aji3MLhOqG1/XSIeJSVL7yEY9IfVp/i7
	 mNPx6PvfC3yqJa+7OAl8ERFZnWHHNE3Fr6HTsrcQD03LOUCOtWSLgnOyy3M+E5X+fw
	 1VDIm1TAgbA1A==
Date: Tue, 20 Jan 2026 14:40:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, 
	Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, djwong@kernel.org, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260120-neuland-rastplatz-31cc7d61a196@brauner>
References: <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
 <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
 <20260120065242.GA3436@lst.de>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120065242.GA3436@lst.de>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [2.30 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2090-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux.alibaba.com,huawei.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,linux-foundation.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:hsiangkao@linux.alibaba.com,m:lihongbo22@huawei.com,m:chao@kernel.org,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:oliver.yang@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0BDDB4637D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:52:42AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 20, 2026 at 11:07:48AM +0800, Gao Xiang wrote:
> >
> > Hi Christoph,
> >
> > Sorry I didn't phrase things clearly earlier, but I'd still
> > like to explain the whole idea, as this feature is clearly
> > useful for containerization. I hope we can reach agreement
> > on the page cache sharing feature: Christian agreed on this
> > feature (and I hope still):
> >
> > https://lore.kernel.org/linux-fsdevel/20260112-begreifbar-hasten-da396ac2759b@brauner
> 
> He has to ultimatively decide.  I do have an uneasy feeling about this.
> It's not super informed as I can keep up, and I'm not the one in charge,
> but I hope it is helpful to share my perspective.

It always is helpful, Christoph! I appreciate your input.

I'm fine with this feature. But as I've said in person: I still oppose
making any block-based filesystem mountable in unprivileged containers
without any sort of trust mechanism.

I am however open in the future for block devices protected by dm-verity
with the root hash signed by a sufficiently trusted key to be mountable
in unprivileged containers.

