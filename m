Return-Path: <linux-erofs+bounces-2207-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DqNIhITc2lksAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2207-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 07:20:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A480870D2B
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 07:20:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy77z2p3Dz2xKh;
	Fri, 23 Jan 2026 17:19:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769149199;
	cv=none; b=MVYgnjGUisMk5fEU2OgdBNtLtHN9w2pwq3CVRK/QNqO3a+iQNUwJttYotowy3X69Te57eXpFztK1VY+s5Cv8PjZNSn8bYgciKxTGSCA5mH1agek0wTm6QvTAvF9XFURSLywdYzCEX5w+jL8C8SHhY7lJTUu/cnk2AX7CM45JsKeekTrwMn00qdL5Cs4SoaLJs/HCByImnYU5Ettv7i0RNuq9t6zzaJmV3kwtOKhLuTvZkWa8ccLyjE3r/FtSG5r10REqOU1SsOPCX2MZCHeEa8aGvd89gGbbsk3aRz8FedhzLQ2AQhW0G7m9FGm3AIXx4/lbsNzF/tiBPZkCePbdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769149199; c=relaxed/relaxed;
	bh=EBk2JD+DROPTKKT714UE0CxnnzXXppl1XqBx3ZXsJi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm6RWEwb0WFH1iIozaWpHTbQ8NrqvtL96Sm6eR/llrezXzLwlOAKXXP/TDOBm+j5JZhcwD5wpXaX8sXylzCebxvDvheTrY5vhS7rzyT0Aoc1N3MyHzb3uuelCeaVo78h52qy88wyTF4OcPIEgFKuGJde1FuAI/oaLLRRV0mk/e96g4yBERsFHiodhvr9gR01eSAEUFlC3fhMDjQpTp5zLpht6br2WSmQ9Fr4OWEeOEFN4sWAJLXKHmcHFlkFFSKWrj20ETFP6d89dKjPs9Vu7ZD/88gyUCN4lfhyqOdTqlZyG8F2/xVdWtdweFpRDEh8T9UDYQJDdb2Npl/uXKHTzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy77y4vHtz2xJ5
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 17:19:58 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47569227AAE; Fri, 23 Jan 2026 07:19:55 +0100 (CET)
Date: Fri, 23 Jan 2026 07:19:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, hsiangkao@linux.alibaba.com,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260123061955.GB25722@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <5aa7566e-c30c-470a-ab77-8b62a3cdf8c3@huawei.com> <ffdfbf7c-25fc-47ca-8c90-c98301847a1f@huawei.com>
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
In-Reply-To: <ffdfbf7c-25fc-47ca-8c90-c98301847a1f@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2207-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:lihongbo22@huawei.com,m:hch@lst.de,m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:brauner@kernel.org,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lst.de,linux.alibaba.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.358];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: A480870D2B
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:48:27PM +0800, Hongbo Li wrote:
> Sorry I overlooked this point. Factoring this out is a good idea, but we 
> cannot use IS_ENABLED here, because some aops is not visible  when the 
> relevant config macro is not enabled. So I choose to keep this format and 
> only to factor this out.

Is it?  If so just moving the extern outside the ifdef should be
easy enough, but from a quick grep I can't see any such case.


