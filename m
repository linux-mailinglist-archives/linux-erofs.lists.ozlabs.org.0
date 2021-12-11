Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B8402471248
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 07:57:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9z9t4Zbsz3cNW
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 17:57:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9z9m6FbMz3c7D
 for <linux-erofs@lists.ozlabs.org>; Sat, 11 Dec 2021 17:57:44 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=13; SR=0; TI=SMTPD_---0V-DZw3U_1639205850; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-DZw3U_1639205850) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 11 Dec 2021 14:57:33 +0800
Date: Sat, 11 Dec 2021 14:57:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [Linux-cachefs] [RFC 09/19] netfs: refactor netfs_rreq_unlock()
Message-ID: <YbRL2glGzjfZkVbH@B-P7TQMD6M-0146.local>
Mail-Followup-To: JeffleXu <jefflexu@linux.alibaba.com>,
 David Howells <dhowells@redhat.com>, chao@kernel.org,
 tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 xiang@kernel.org, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, eguan@linux.alibaba.com
References: <20211210073619.21667-10-jefflexu@linux.alibaba.com>
 <20211210073619.21667-1-jefflexu@linux.alibaba.com>
 <292572.1639150908@warthog.procyon.org.uk>
 <fba8a28b-14c1-bf58-0578-32415c95f55d@linux.alibaba.com>
 <a95618c5-723d-bfaa-bf7a-48950be8d31d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a95618c5-723d-bfaa-bf7a-48950be8d31d@linux.alibaba.com>
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, eguan@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jeffle,

On Sat, Dec 11, 2021 at 01:44:47PM +0800, JeffleXu wrote:
> 
> 
> On 12/11/21 1:23 PM, JeffleXu wrote:
> > 
> > 
> > On 12/10/21 11:41 PM, David Howells wrote:
> >> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >>
> >>> In demand-read case, the input folio of netfs API is may not the page
> >>
> >> "is may not the page"?  I think you're missing a verb (and you have too many
> >> auxiliary verbs;-)
> >>
> > 
> > Sorry for my poor English... What I want to express is that
> > 
> > "In demand-read case, the input folio of netfs API may not be the page
> > cache inside the address space of the netfs file."
> > 
> 
> By the way, can we change the current address_space based netfs API to
> folio-based, which shall be more general? That is, the current
> implementation of netfs API uses (address_space, page_offset, len) tuple
> to describe the destination where the read data shall be store into.
> While in the demand-read case, the input folio may not be the page
> cache, and thus there's no address_space attached with it.

Thanks for your hard effort on this!

Just a rough look. Could we use a pseudo inode (actually the current
managed_inode can be used as this) to retain metadata for fscache
scenarios? (since it's better to cache all metadata rather than drop
directly, also the alloc_page() - free_page() cycle takes more time).

Also if my own limited understanding is correct, you could directly
use file inode pages with netfs_readpage_demand() rather than
get_meta_page and then memcpy to the file inode pages.

Thanks,
Gao Xiang

> 
> -- 
> Thanks,
> Jeffle
