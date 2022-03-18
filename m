Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05E84DD471
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 06:42:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKXvm64l8z30D6
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 16:42:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKXvh0NPQz2ynj
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 16:42:07 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R261e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7V4qT._1647582119; 
Received: from 30.225.24.52(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7V4qT._1647582119) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 18 Mar 2022 13:42:00 +0800
Message-ID: <be2a500d-f8f3-f813-cb9e-04ac1726e22d@linux.alibaba.com>
Date: Fri, 18 Mar 2022 13:41:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 21/22] erofs: implement fscache-based data readahead
Content-Language: en-US
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-22-jefflexu@linux.alibaba.com>
 <YjLFsCLeEU9glmNf@B-P7TQMD6M-0146.local>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YjLFsCLeEU9glmNf@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/17/22 1:22 PM, Gao Xiang wrote:
> On Wed, Mar 16, 2022 at 09:17:22PM +0800, Jeffle Xu wrote:
>> This patch implements fscache-based data readahead. Also registers an
>> individual bdi for each erofs instance to enable readahead.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/fscache.c | 153 +++++++++++++++++++++++++++++++++++++++++++++
>>  fs/erofs/super.c   |   4 ++
>>  2 files changed, 157 insertions(+)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 82c52b6e077e..913ca891deb9 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -10,6 +10,13 @@ struct erofs_fscache_map {
>>  	u64 m_llen;
>>  };
>>  
>> +struct erofs_fscahce_ra_ctx {
> 
> typo,  should be `erofs_fscache_ra_ctx'

Oops. Thanks.


> 
>> +	struct readahead_control *rac;
>> +	struct address_space *mapping;
>> +	loff_t start;
>> +	size_t len, done;
>> +};
>> +
>>  static struct fscache_volume *volume;
>>  
>>  /*
>> @@ -199,12 +206,158 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>>  	return ret;
>>  }
>>  
>> +static inline size_t erofs_fscache_calc_len(struct erofs_fscahce_ra_ctx *ractx,
>> +					    struct erofs_fscache_map *fsmap)
>> +{
>> +	/*
>> +	 * 1) For CHUNK_BASED layout, the output m_la is rounded down to the
>> +	 * nearest chunk boundary, and the output m_llen actually starts from
>> +	 * the start of the containing chunk.
>> +	 * 2) For other cases, the output m_la is equal to o_la.
>> +	 */
>> +	size_t len = fsmap->m_llen - (fsmap->o_la - fsmap->m_la);
>> +
>> +	return min_t(size_t, len, ractx->len - ractx->done);
>> +}
>> +
>> +static inline void erofs_fscache_unlock_pages(struct readahead_control *rac,
>> +					      size_t len)
> 
> Can we convert them into folios in advance? it seems much
> straight-forward to convert these...
> 
> Or I have to convert them later, and it seems unnecessary...

OK I will try to use folio API in the next version.


> 
> 
>> +{
>> +	while (len) {
>> +		struct page *page = readahead_page(rac);
>> +
>> +		SetPageUptodate(page);
>> +		unlock_page(page);
>> +		put_page(page);
>> +
>> +		len -= PAGE_SIZE;
>> +	}
>> +}
>> +
>> +static int erofs_fscache_ra_hole(struct erofs_fscahce_ra_ctx *ractx,
>> +				 struct erofs_fscache_map *fsmap)
>> +{
>> +	struct iov_iter iter;
>> +	loff_t start = ractx->start + ractx->done;
>> +	size_t length = erofs_fscache_calc_len(ractx, fsmap);
>> +
>> +	iov_iter_xarray(&iter, READ, &ractx->mapping->i_pages, start, length);
>> +	iov_iter_zero(length, &iter);
>> +
>> +	erofs_fscache_unlock_pages(ractx->rac, length);
>> +	return length;
>> +}
>> +
>> +static int erofs_fscache_ra_noinline(struct erofs_fscahce_ra_ctx *ractx,
>> +				     struct erofs_fscache_map *fsmap)
>> +{
>> +	struct fscache_cookie *cookie = fsmap->m_ctx->cookie;
>> +	loff_t start = ractx->start + ractx->done;
>> +	size_t length = erofs_fscache_calc_len(ractx, fsmap);
>> +	loff_t pstart = fsmap->m_pa + (fsmap->o_la - fsmap->m_la);
>> +	int ret;
>> +
>> +	ret = erofs_fscache_read_pages(cookie, ractx->mapping,
>> +				       start, length, pstart);
>> +	if (!ret) {
>> +		erofs_fscache_unlock_pages(ractx->rac, length);
>> +		ret = length;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int erofs_fscache_ra_inline(struct erofs_fscahce_ra_ctx *ractx,
>> +				   struct erofs_fscache_map *fsmap)
>> +{
> 
> We could fold in this, since it has the only user.

OK, and "struct erofs_fscahce_ra_ctx" is not needed then.

-- 
Thanks,
Jeffle
