Return-Path: <linux-erofs+bounces-3075-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dC3dKXsByWlLtQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3075-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 12:39:55 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F97351988
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 12:39:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fk9qq5qxwz2yYs;
	Sun, 29 Mar 2026 21:39:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:192:486::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774780791;
	cv=none; b=CVKvo6akwmKE1rD1jUJC+QKJMt3YxqX07z+5j2IuBHlWLO/8PHo+JvV+w10u9TFH2f4QhZp61pae5yEr4YauCAizBi2H4yrR7v3exLtrcwjDpcev7HUgmZXF7Xvcu2tK9OY8tAL4hOzBAjEEdHtMHgaKoMbU7+a4B/J4+xHB3ZGGN4prrAzkROJf4kc6kWkImME56tyL0q92mQeXRgybT1hwVnEkru9V/A5nNv4uwyHK9DDmMvPb9G95jZIcLXYWAvD0pLzte3xURUuQUjN/t5yTFdf/kPXKdqOLd/JDg3WVsXYlPFcWY+JbJU1JhMj4iKu/yVSkTbXvDRIg7msrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774780791; c=relaxed/relaxed;
	bh=35kKxUVBYro2SeM6ocrFn0qXSAY7oP/wMRsnYfWK9ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ah+3XPGtPZ6hvt6WwCj3h1RBMiPpomdOgsjzMQJbWCGimUWWohcGNJuzPR21Qg67E7Amm65OJM2QJT5qE7jcVKMrOkWRZovjFYLiNO+vvgONzN0yF+I4LeJnKCJSM8pzRX8pdQeaewJfhyDlnA/DKRnIgfAJSviNkKsSQI77Nt/7wfC+Ag8ujJ7DRNwDuAtxLiQs+2oAkUqCU2j65JQaNiDvWxVCouFfKWxGBWsK7ydjMJwW7ywQ/nXXV+lN2x/tGe8TTGFBx9iFBl+MzTkEpxC19D2PQS2OrhUTPDmdjEG0y3ZElQ8XKmr9XxurdbwRKn02HiT+Ll4QxZAt+XJicA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=LSA/p24b; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org) smtp.mailfrom=samba.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=LSA/p24b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samba.org (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org)
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fk9qp5LbZz2xlK
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 21:39:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=35kKxUVBYro2SeM6ocrFn0qXSAY7oP/wMRsnYfWK9ak=; b=LSA/p24bex3iCNjrbr2Y3gClIg
	smlF06ao/O1GVSiKS7XeUE24ZKDRYRwvOOzGM8uoA5rnb22Onyz1P8NBz9nGSfD/g3jS2nNqaPe9A
	DGfj2L8iJCkYb47IpNE4El3HuTyRODDTi7K13OlSPJmD+8WCXL9ubiVLHtkKyqwAhiGKCY/rT3gLP
	2ICJJjnfxuJHHMduL5P1My7iVnuIgv1lZlGkVlKfapfkpCpAIQITV7o3CLnmmKwomXJpbpwZ0Xa4x
	StLcOYfQf7Yqnu+iARwQNmAcqiu8lYmHl/YikLgN3Lw+b4KbTM5WgoIStacBJ8UP4wo2toCUHDLe4
	+OKQRehRm9bUN9Xcg761+3HHfNTWuPPjmKqrJ+qMOT5roAzTNNAztSCEL1wM32TKxr3iPjmNiGwno
	nvpVS8TIGe+8LcHASXL1CLVANYD93DcMII9vVSIha9G1usEaQwj8z3U50VDUeR2omGhj2An0CsqxF
	Q3NFYFpj5ztkVfHsH2utDuUE;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1w6nYZ-00000004jEZ-0gHh;
	Sun, 29 Mar 2026 10:39:47 +0000
Message-ID: <3f19c05a-d8aa-4ce5-8bcf-b51a1f110cb5@samba.org>
Date: Sun, 29 Mar 2026 12:39:46 +0200
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
Subject: Re: [PATCH 19/26] cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from
 smb_extract_iter_to_rdma()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
 Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-20-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260326104544.509518-20-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3075-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[metze@samba.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org,microsoft.com,talpey.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pc@manguebit.org,m:sprasad@microsoft.com,m:tom@talpey.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:dkim,samba.org:email,samba.org:mid,linux.dev:email]
X-Rspamd-Queue-Id: A0F97351988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

in ksmbd-for-next smbdirect_map_sges_from_iter is also called
in the server from smb_direct_writev() =>
smbdirect_connection_send_iter() =>
smbdirect_connection_send_single_iter()

So we still need ITER_KVEC.

Thanks!
metze

Am 26.03.26 um 11:45 schrieb David Howells:
> netfslib now only presents an bvecq queue and an associated ITER_BVECQ
> iterator to the filesystem, so it isn't going to see ITER_KVEC, ITER_BVEC
> or ITER_FOLIOQ iterators.  So remove that code.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/smb/client/smbdirect.c | 165 --------------------------------------
>   1 file changed, 165 deletions(-)
> 
> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> index f8a6be83db98..d9e026d5e9f9 100644
> --- a/fs/smb/client/smbdirect.c
> +++ b/fs/smb/client/smbdirect.c
> @@ -3142,162 +3142,6 @@ static bool smb_set_sge(struct smb_extract_to_rdma *rdma,
>   	return true;
>   }
>   
> -/*
> - * Extract page fragments from a BVEC-class iterator and add them to an RDMA
> - * element list.  The pages are not pinned.
> - */
> -static ssize_t smb_extract_bvec_to_rdma(struct iov_iter *iter,
> -					struct smb_extract_to_rdma *rdma,
> -					ssize_t maxsize)
> -{
> -	const struct bio_vec *bv = iter->bvec;
> -	unsigned long start = iter->iov_offset;
> -	unsigned int i;
> -	ssize_t ret = 0;
> -
> -	for (i = 0; i < iter->nr_segs; i++) {
> -		size_t off, len;
> -
> -		len = bv[i].bv_len;
> -		if (start >= len) {
> -			start -= len;
> -			continue;
> -		}
> -
> -		len = min_t(size_t, maxsize, len - start);
> -		off = bv[i].bv_offset + start;
> -
> -		if (!smb_set_sge(rdma, bv[i].bv_page, off, len))
> -			return -EIO;
> -
> -		ret += len;
> -		maxsize -= len;
> -		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
> -			break;
> -		start = 0;
> -	}
> -
> -	if (ret > 0)
> -		iov_iter_advance(iter, ret);
> -	return ret;
> -}
> -
> -/*
> - * Extract fragments from a KVEC-class iterator and add them to an RDMA list.
> - * This can deal with vmalloc'd buffers as well as kmalloc'd or static buffers.
> - * The pages are not pinned.
> - */
> -static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
> -					struct smb_extract_to_rdma *rdma,
> -					ssize_t maxsize)
> -{
> -	const struct kvec *kv = iter->kvec;
> -	unsigned long start = iter->iov_offset;
> -	unsigned int i;
> -	ssize_t ret = 0;
> -
> -	for (i = 0; i < iter->nr_segs; i++) {
> -		struct page *page;
> -		unsigned long kaddr;
> -		size_t off, len, seg;
> -
> -		len = kv[i].iov_len;
> -		if (start >= len) {
> -			start -= len;
> -			continue;
> -		}
> -
> -		kaddr = (unsigned long)kv[i].iov_base + start;
> -		off = kaddr & ~PAGE_MASK;
> -		len = min_t(size_t, maxsize, len - start);
> -		kaddr &= PAGE_MASK;
> -
> -		maxsize -= len;
> -		do {
> -			seg = min_t(size_t, len, PAGE_SIZE - off);
> -
> -			if (is_vmalloc_or_module_addr((void *)kaddr))
> -				page = vmalloc_to_page((void *)kaddr);
> -			else
> -				page = virt_to_page((void *)kaddr);
> -
> -			if (!smb_set_sge(rdma, page, off, seg))
> -				return -EIO;
> -
> -			ret += seg;
> -			len -= seg;
> -			kaddr += PAGE_SIZE;
> -			off = 0;
> -		} while (len > 0 && rdma->nr_sge < rdma->max_sge);
> -
> -		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
> -			break;
> -		start = 0;
> -	}
> -
> -	if (ret > 0)
> -		iov_iter_advance(iter, ret);
> -	return ret;
> -}
> -
> -/*
> - * Extract folio fragments from a FOLIOQ-class iterator and add them to an RDMA
> - * list.  The folios are not pinned.
> - */
> -static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
> -					  struct smb_extract_to_rdma *rdma,
> -					  ssize_t maxsize)
> -{
> -	const struct folio_queue *folioq = iter->folioq;
> -	unsigned int slot = iter->folioq_slot;
> -	ssize_t ret = 0;
> -	size_t offset = iter->iov_offset;
> -
> -	BUG_ON(!folioq);
> -
> -	if (slot >= folioq_nr_slots(folioq)) {
> -		folioq = folioq->next;
> -		if (WARN_ON_ONCE(!folioq))
> -			return -EIO;
> -		slot = 0;
> -	}
> -
> -	do {
> -		struct folio *folio = folioq_folio(folioq, slot);
> -		size_t fsize = folioq_folio_size(folioq, slot);
> -
> -		if (offset < fsize) {
> -			size_t part = umin(maxsize, fsize - offset);
> -
> -			if (!smb_set_sge(rdma, folio_page(folio, 0), offset, part))
> -				return -EIO;
> -
> -			offset += part;
> -			ret += part;
> -			maxsize -= part;
> -		}
> -
> -		if (offset >= fsize) {
> -			offset = 0;
> -			slot++;
> -			if (slot >= folioq_nr_slots(folioq)) {
> -				if (!folioq->next) {
> -					WARN_ON_ONCE(ret < iter->count);
> -					break;
> -				}
> -				folioq = folioq->next;
> -				slot = 0;
> -			}
> -		}
> -	} while (rdma->nr_sge < rdma->max_sge && maxsize > 0);
> -
> -	iter->folioq = folioq;
> -	iter->folioq_slot = slot;
> -	iter->iov_offset = offset;
> -	iter->count -= ret;
> -	return ret;
> -}
> -
>   /*
>    * Extract memory fragments from a BVECQ-class iterator and add them to an RDMA
>    * list.  The folios are not pinned.
> @@ -3373,15 +3217,6 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
>   	int before = rdma->nr_sge;
>   
>   	switch (iov_iter_type(iter)) {
> -	case ITER_BVEC:
> -		ret = smb_extract_bvec_to_rdma(iter, rdma, len);
> -		break;
> -	case ITER_KVEC:
> -		ret = smb_extract_kvec_to_rdma(iter, rdma, len);
> -		break;
> -	case ITER_FOLIOQ:
> -		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
> -		break;
>   	case ITER_BVECQ:
>   		ret = smb_extract_bvecq_to_rdma(iter, rdma, len);
>   		break;
> 


