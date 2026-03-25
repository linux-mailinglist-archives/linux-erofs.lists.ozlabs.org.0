Return-Path: <linux-erofs+bounces-3009-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NRdNn0zxGkAxQQAu9opvQ
	(envelope-from <linux-erofs+bounces-3009-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 20:11:57 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6991432B0DC
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 20:11:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgxNS5TNNz2yVB;
	Thu, 26 Mar 2026 06:11:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774465912;
	cv=none; b=ZWuNuCPkuC39NCNiBosaeG00BmZf5bCzrDfGw6HStHZD6SvzAFY0ZCgFtCdr3wsz0nzsRS3nfnaWaHEs0emUGygEMbDfcDTyGo7+4MwyqEWrwfBa4ICxzDoTxF0e9cf+0dILxzdEWfukWjJOrbcYgsWGzo9lqUP/1YSB74BjfXaRyqj1WyM9u5/faOplUwnfYiRLMyjvD87IqYZtVuJizJ3Ed1sCeFfuY32AdAyK+JURQCZgDNGmGq/cZT+jN6VOCU1RN+Ura7pk25s4Opv4KKSQnU3iXhKkCRSANMaNLfGweQ9xzXU403AD6jFiE+PF2NDYGaFwMCXQJiC0dBaT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774465912; c=relaxed/relaxed;
	bh=po04g+LbVixcaFTdbtAzejVAtFF7E6B6fHxWMAEB7DQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ejvolrmDis+jzD/+/PhheFwklo2P6PnlDEzGQ/ow4khXQBsTofpQQypCCBXZ0pGxG72ATN93EdFXbb4feytsbYJHFKbRd7R+nGtDrzVPvVTpxIlp0Mecv3s2GMZF9ntevtq2eHlDM5qYN8371zA+NyLOj0NJQ9GaFmhM+RdIIOREPRa6FsyH0TT0eYjdz1M13Kp7OqAI8j4+bjezmjgVD/iLKHctn15XjcA9zZqXhdHSgIe9yBmBwDBEBKtvADgWn899mTAuk7/0n1aQHUVZoLdMnAmFTk/i7J/VWW3EMYR6j52N0XhsZrOlRHLAvD1WUPB/QM1Uli5xK2AZjepqPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=n+B7jA29; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=n+B7jA29;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgxNQ41m8z2xSX
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 06:11:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 91BEB4052A;
	Wed, 25 Mar 2026 19:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F077C19423;
	Wed, 25 Mar 2026 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774465907;
	bh=R8trGOgutAbT9TZyCLIzQHNIqzASbQS+83BkcRfxwPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n+B7jA29HYBmodMSUv0jabYWqYQkkzI25KIVUfzjjK3zF1RxFmsERQAksEeZZEv1h
	 iDMFChCVfnLLUa7gKSv1HXmC8QYOQ2DoFFNevqSjWHHy7buMTrhvRcmzF6+Bru4h1/
	 SBYFb48e+BEYOYgHK10JdqzPoTkS++h4SrH0RokU=
Date: Wed, 25 Mar 2026 12:11:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Gao Xiang <xiang@kernel.org>, Chao Yu
 <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, Hongbo
 Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Tony Luck
 <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Dave
 Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, Babu Moger
 <babu.moger@amd.com>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
 <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: always inline __mk_vma_flags() and invoked
 functions
Message-Id: <20260325121145.24f51861d9933f8577b7d6c7@linux-foundation.org>
In-Reply-To: <1ae3915e-19ef-4be0-aa5f-fd66a2e18179@lucifer.local>
References: <cover.1772704455.git.ljs@kernel.org>
	<241f49c52074d436edbb9c6a6662a8dc142a8f43.1772704455.git.ljs@kernel.org>
	<ndtnvnobevdymu5a5tdxdbi4tcsqshs3d6x2vnfgnuclxvgwok@bhbqkzilsets>
	<d352055d-06fe-43b2-8ad3-b73ab99683d0@lucifer.local>
	<20260325090949.795e06f48ec455053db9ae89@linux-foundation.org>
	<959b34ea-69a7-4fda-a494-0b9a1773ec1d@lucifer.local>
	<20260325112755.e62cd89508224f703239f03a@linux-foundation.org>
	<1ae3915e-19ef-4be0-aa5f-fd66a2e18179@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:pfalcato@suse.de,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:jack@suse.cz,m:Liam.Howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:jannh@google.com,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-mm@kvack.org,m:ntfs3@lists.linux
 .dev,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3009-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6991432B0DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 18:44:13 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:

> > : Be explicit about __mk_vma_flags() (which is used by the mk_vma_flags()
> > : macro) always being inline, as we rely on the compiler turning all
> > : constants into compile-time ones.
> >
> 
> Well I think that loses the meaning a bit.
> 
> Something like:
> 
> Be explicit about __mk_vma_flags() (which is used by the mk_vma_flags()
> -macro) always being inline, as we rely on the compiler converting this
> -function into meaningful.
> +macro) always being inline, as we rely on the compiler to evaluate the
> +loop in this function and determine that it can replace the code with the
> +an equivalent constant value, e.g. that:
> +
> +__mk_vma_flags(2, (const vma_flag_t []){ VMA_WRITE_BIT, VMA_EXEC_BIT });
> +
> +Can be replaced with:
> +
> +(1UL << VMA_WRITE_BIT) | (1UL << VMA_EXEC_BIT)
> +
> += (1UL << 1) | (1UL << 2) = 6
> +
> +Most likely an 'inline' will suffice for this, but be explicit as we can
> +be.
> 
> Should verbosely cover that off.

ok ;)

