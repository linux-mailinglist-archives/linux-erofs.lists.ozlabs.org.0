Return-Path: <linux-erofs+bounces-3483-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OihOJ7oE2p8HQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3483-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 25 May 2026 08:13:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403FE5C63D4
	for <lists+linux-erofs@lfdr.de>; Mon, 25 May 2026 08:13:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP5DS345zz2xnK;
	Mon, 25 May 2026 16:13:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779689624;
	cv=none; b=dHRN0NuL9V0CJnd8nsvnPUMVJKOw48L+n+pwGOCiebkaGEeFTs7he3/TDC0yU0UG2sqDw2eDdcBf9ULoT7uq9dZ70gs3SNAPaj098oBpp/LOC8AoZTotlFKPa6GqNDWZVOk91sRLaTFfTe+Edp5oBgGt2aaPOE6T0x2pz8WzZOgEd5PEsV0x3dmqcJmA6jXzDW9j2f5KLNaDIeeE8F24Ehrklkpy8dOVyGza8eqgPR29bjW/Kqm2DTKhu9fErSuv70PTaKBuDdpE3j4ZpPvkabqiLTamVWq3+A/I1Hy+KDsOTLtuxDafy7rV5Gvyq1pSb/XYASaCtzgjBALMKWJQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779689624; c=relaxed/relaxed;
	bh=k3SPzxVyWdadKptBoGs22ABp+4fSutAbLhXgTnFnk+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEGk3cn4vwK/L+uGXkTWbNHj1x5uDeufTDauphre6d7iBjKUa6L3hAVO1KmCICPe6601Emv8jxqey11jUEvbQDTTAc6nRz9QhvWPW2moK20KKAdiGVIxOvOT190G8GRssvh/qHlG//93m22nF+D7B67eEt3u2E97o7IFmM7uMVvnWWEu0c2GkED2sPhpSUJPSCqxuw+ely3b9ipxNcA4o3ACpfBnq+WZR5CtFICGMcNQsnFJgr2E1aqE1JQY61xl6y9tCbVkAZ7uf1JyxirbDzHUP0Filf1e72SrFgHiMX7ZMw9hRjOn1FCvzOpUCAoMVQGSk1+6H9q5CR04AD5LhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+728b97dfb722ff21c2bb+8310+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+728b97dfb722ff21c2bb+8310+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP5DJ61lYz2xk7
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 May 2026 16:13:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k3SPzxVyWdadKptBoGs22ABp+4fSutAbLhXgTnFnk+c=; b=ch8C4AQus3YZ806Wh67oNprJWu
	4YgLFI2/PnBCMuybdDy7PbfGtTtnOYTERUedeW5E5Ru5s2A42Wbka5YWGITgpXyoniyxVkeoX4jLc
	IUiRdYgZdzB/Am4gsRBuGO/BRVBQ7wRZfgKXj1zZbTQQSFMZAafdMq1Nx00l5Uir2sYkM1+syo7Sb
	tR2MZOHYxgUNgn6enT0n7mgnTQttQ6CNWFQCnUaBYMiOmFQAvhU06ASH+830Qwzg/OZoJ2MMde8pk
	5myaDznWnGdkaDDiOgZB+6sZOcmbLJfO3PHqjAYQdxaW+wE6I2paALx9V82PLnhPBfyxJiW3AXzQ8
	ADrqVaWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROYn-0000000GOIp-2PQ1;
	Mon, 25 May 2026 06:13:09 +0000
Date: Sun, 24 May 2026 23:13:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 05/21] Add a function to kmap one page of a multipage
 bio_vec
Message-ID: <ahPodavlA-gt44FO@infradead.org>
References: <20260518222959.488126-1-dhowells@redhat.com>
 <20260518222959.488126-6-dhowells@redhat.com>
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
In-Reply-To: <20260518222959.488126-6-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3483-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[brauner.io,infradead.org,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,kernel.dk:email,linux.dev:email,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 403FE5C63D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 11:29:37PM +0100, David Howells wrote:
> Add a function to kmap one page of a multipage bio_vec by offset (which is
> added to the offset in the bio_vec internally).  The caller is responsible
> for calculating how much of the page is then available.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-block@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  include/linux/bvec.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index d36dd476feda..9df4a56fef61 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -299,4 +299,21 @@ static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
>  	return page_to_phys(bvec->bv_page) + bvec->bv_offset;
>  }
>  
> +/**
> + * kmap_local_bvec - Map part of a bvec into the kernel virtual address space
> + * @bvec: bvec to map
> + * @offset: Offset into bvec
> + *
> + * Map the page containing the byte at @offset into the kernel virtual address
> + * space.  The caller is responsible for making sure this doesn't overrun.
> + *
> + * Call kunmap_local on the returned address to unmap.
> + */
> +static inline void *kmap_local_bvec(struct bio_vec *bvec, size_t offset)

The name is rather confusing for something that does not map the entire
bvec, and is an anagram of the existing bvec_kmap_local.  So please
rename it to bvec_kmap_partial or something.

> +{
> +	offset += bvec->bv_offset;
> +
> +	return kmap_local_page(bvec->bv_page + offset / PAGE_SIZE) + offset % PAGE_SIZE;

Overly long line.  Also this can use shits and byte masking to be a tad
more efficient and matching the rest of the bvec code.

Users of this would be interesting and why you're not simply using a
bvec_iter at page granularity, which is what other block kmap code
does.


