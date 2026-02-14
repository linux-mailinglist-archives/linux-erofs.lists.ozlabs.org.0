Return-Path: <linux-erofs+bounces-2318-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZPZEF5Phj2npUAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2318-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Feb 2026 03:44:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EBB13ACEE
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Feb 2026 03:44:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fCYK91pBMz2xln;
	Sat, 14 Feb 2026 13:44:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771037069;
	cv=none; b=Wud5qzldID3hCtcslrOOeig+uh0/0NRANFPAB2yESzeotsfO1GrI/qjfyZaeLIqr48uYdfLQZ/qcyAbfAld79ONDKv0zjcJj67xm0y7f7FIqVR2OeAI46ddihrleiuDfRqHBAgMx80jJcVVuExZE/OLKJXBS1s+z2uOIFLvSlaifCAGRR3hK4iA3aREukvki7Xt+ZL7a5myAw93m5ZF72zHGMtFr/FeFvpvPRm6L84Na9AORT6F2yoGpbHLKsSAxFHxs/8GvmMS0vGPORl12a9uxcn5E/Fb6Q/dIsTNKcp6YsQsO5iL2VZOpOw+PxM3qIV1agqfcq8zeeiTUEjatdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771037069; c=relaxed/relaxed;
	bh=yirB9/4LDiWmr8q/m75cr3j4OYclYINLRP1aL/K+uXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfgUUVoEA3VkWXRxOJf99MadF03HBpi119hjDVBOHzhbwLVsRQysobdp0fF1w0tlTnRPf3rwgLiL5ZLRpiu3g9vP8wHvTCVpqbDgoPNuNTvUcJCmPcAQhXCHmx/EjE2yF7MxlN2FLgdk3nv9ekPV7qVGzlDIGteqUpocoCq67QjofjuOIVUO2GH4Dsvdsx9XSygxJPkXlQ0XGIqovwNAfqzcbmt8IGulRcmJg6An8lUDUzxD1G4wdYShzoN8TD3sZuBezc+PANAQ4feslK4kW8ulotG/XXpeUWouO+Ji3OOFgs2D4y1R/sB2EO8aeecOlLguExAU+MduDJ4ya9ejBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IWgRSP6g; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IWgRSP6g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fCYK83WQGz2xSF
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Feb 2026 13:44:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D28F041E4A;
	Sat, 14 Feb 2026 02:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A34C116C6;
	Sat, 14 Feb 2026 02:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771037065;
	bh=yirB9/4LDiWmr8q/m75cr3j4OYclYINLRP1aL/K+uXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWgRSP6goIyRjbWPfxTVg2485HnAvjm2Mndgwbq22cAtx6knnPfwOQZ36JqBVMSTE
	 NxFRc1HCpzqUmH4gsWPN19+rOk8BZO7k/b2pW2BzEjW+Vxf+u6cLd/bM0VcCXF/X2o
	 hvz3YbP8fqBHZbtEqEw8v06H8n7xFoNSx4OFsvruDuc8tMCN5JfIDxHGXAVaxPAs10
	 qQG+K+Ua7xiVmVchl/48FYrJyWb1Hz5pEvc2aYxsPCoDbfCMMYF2NDnIp/5TxEqPVF
	 kb2TQMlzOsl6KZ6+LX6xRHO+NT/Lrf+qyZGoeOMDQ0U3p6e4BNC3yYbnOyHNp8UKUA
	 hODAGW5HI/f3w==
Date: Sat, 14 Feb 2026 10:44:20 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yifan Zhao <zhaoyifan28@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	jingrui@huawei.com, wayne.ma@huawei.com, zhukeqian1@huawei.com
Subject: Re: [PATCH 1/2] erofs-utils: manpage: document missing options for
 mkfs.erofs
Message-ID: <aY_hhKH67D4JVVyf@debian>
Mail-Followup-To: Yifan Zhao <zhaoyifan28@huawei.com>,
	linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	jingrui@huawei.com, wayne.ma@huawei.com, zhukeqian1@huawei.com
References: <20260213073241.525158-1-zhaoyifan28@huawei.com>
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
In-Reply-To: <20260213073241.525158-1-zhaoyifan28@huawei.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:jingrui@huawei.com,m:wayne.ma@huawei.com,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2318-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 43EBB13ACEE
X-Rspamd-Action: no action

Hi Yifan,

On Fri, Feb 13, 2026 at 03:32:40PM +0800, Yifan Zhao wrote:
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---

I rearrange this a bit and apply it to -experimental.

Thanks,
Gao Xiang

