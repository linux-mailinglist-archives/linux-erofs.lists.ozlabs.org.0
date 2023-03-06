Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 276C76AB9B8
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 10:25:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVY7z1mDyz3cFH
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 20:25:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVY7v3kCVz2xVn
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 20:24:58 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VdDPjS5_1678094693;
Received: from 30.97.49.22(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdDPjS5_1678094693)
          by smtp.aliyun-inc.com;
          Mon, 06 Mar 2023 17:24:54 +0800
Message-ID: <a29c01b5-2a53-80dd-552a-8762d7df903a@linux.alibaba.com>
Date: Mon, 6 Mar 2023 17:24:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] erofs-utils: get rid of z_erofs_do_map_blocks()
 forward declaration
To: Yue Hu <zbestahu@gmail.com>
References: <e90f4dc828bb45b1a3ccbd1769a590410f3a82da.1678092797.git.huyue2@coolpad.com>
 <6d65a6fa-869d-8259-b271-7e20332188f6@linux.alibaba.com>
 <20230306172539.00001276.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230306172539.00001276.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/6 17:25, Yue Hu wrote:
> On Mon, 6 Mar 2023 17:00:25 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> On 2023/3/6 16:54, Yue Hu wrote:
>>> From: Yue Hu <huyue2@coolpad.com>
>>>
>>> Keep in sync with the kernel commit 999f2f9a63f4 ("erofs: get rid of
>>> z_erofs_do_map_blocks() forward declaration").
>>
>> Does z_erofs_do_map_blocks() already keep in sync with the kernel
>> implementation?  Anyway, it's just another question indepentently
>> to this patch.
> 
> Ok, let me correct the message in v2.

Nope, you just need to submit a new patch to sync these.

> 
>>
>>>
>>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
>>> ---
>>>    lib/zmap.c | 156 ++++++++++++++++++++++++++---------------------------
>>>    1 file changed, 76 insertions(+), 80 deletions(-)
>>>
>>> diff --git a/lib/zmap.c b/lib/zmap.c
>>> index 69b468d..3c665f8 100644
>>> --- a/lib/zmap.c
>>> +++ b/lib/zmap.c
>>> @@ -10,10 +10,6 @@
>>>    #include "erofs/io.h"
>>>    #include "erofs/print.h"
>>>    
>>> -static int z_erofs_do_map_blocks(struct erofs_inode *vi,
>>> -				 struct erofs_map_blocks *map,
>>> -				 int flags);
>>> -
>>>    int z_erofs_fill_inode(struct erofs_inode *vi)
>>>    {
>>>    	if (!erofs_sb_has_big_pcluster() &&
>>> @@ -29,82 +25,6 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
>>>    	return 0;
>>>    }
>>>    
>>> -static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>>> -{
>>> -	int ret;
>>> -	erofs_off_t pos;
>>> -	struct z_erofs_map_header *h;
>>> -	char buf[sizeof(struct z_erofs_map_header)];
>>> -
>>> -	if (vi->flags & EROFS_I_Z_INITED)
>>> -		return 0;
>>> -
>>> -	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
>>> -	ret = dev_read(0, buf, pos, sizeof(buf));
>>> -	if (ret < 0)
>>> -		return -EIO;
>>> -
>>> -	h = (struct z_erofs_map_header *)buf;
>>> -	/*
>>> -	 * if the highest bit of the 8-byte map header is set, the whole file
>>> -	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
>>> -	 */
>>> -	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
>>> -		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
>>> -		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
>>> -		vi->z_tailextent_headlcn = 0;
>>> -		goto out;
>>> -	}
>>> -
>>> -	vi->z_advise = le16_to_cpu(h->h_advise);
>>> -	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
>>> -	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
>>> -
>>> -	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
>>> -		erofs_err("unknown compression format %u for nid %llu",
>>> -			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
>>> -		return -EOPNOTSUPP;
>>> -	}
>>> -
>>> -	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
>>> -	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
>>> -	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
>>> -	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
>>> -		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
>>> -			  vi->nid * 1ULL);
>>> -		return -EFSCORRUPTED;
>>> -	}
>>> -
>>> -	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
>>> -		struct erofs_map_blocks map = { .index = UINT_MAX };
>>> -
>>> -		vi->idata_size = le16_to_cpu(h->h_idata_size);
>>> -		ret = z_erofs_do_map_blocks(vi, &map,
>>> -					    EROFS_GET_BLOCKS_FINDTAIL);
>>> -		if (!map.m_plen ||
>>> -		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
>>> -			erofs_err("invalid tail-packing pclustersize %llu",
>>> -				  map.m_plen | 0ULL);
>>> -			return -EFSCORRUPTED;
>>> -		}
>>> -		if (ret < 0)
>>> -			return ret;
>>> -	}
>>> -	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
>>> -	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
>>> -		struct erofs_map_blocks map = { .index = UINT_MAX };
>>> -
>>> -		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
>>> -		ret = z_erofs_do_map_blocks(vi, &map,
>>> -					    EROFS_GET_BLOCKS_FINDTAIL);
>>> -		if (ret < 0)
>>> -			return ret;
>>> -	}
>>> -out:
>>> -	vi->flags |= EROFS_I_Z_INITED;
>>> -	return 0;
>>> -}
>>> -
>>>    struct z_erofs_maprecorder {
>>>    	struct erofs_inode *inode;
>>>    	struct erofs_map_blocks *map;
>>> @@ -675,6 +595,82 @@ out:
>>>    	return err;
>>>    }
>>>    
>>> +static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>>> +{
>>> +	int ret;
>>> +	erofs_off_t pos;
>>> +	struct z_erofs_map_header *h;
>>> +	char buf[sizeof(struct z_erofs_map_header)];
>>> +
>>> +	if (vi->flags & EROFS_I_Z_INITED)
>>> +		return 0;
>>> +
>>> +	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
>>> +	ret = dev_read(0, buf, pos, sizeof(buf));
>>> +	if (ret < 0)
>>> +		return -EIO;
>>> +
>>> +	h = (struct z_erofs_map_header *)buf;
>>> +	/*
>>> +	 * if the highest bit of the 8-byte map header is set, the whole file
>>> +	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
>>> +	 */
>>> +	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
>>> +		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
>>> +		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
>>> +		vi->z_tailextent_headlcn = 0;
>>> +		goto out;
>>> +	}
>>> +
>>> +	vi->z_advise = le16_to_cpu(h->h_advise);
>>> +	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
>>> +	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
>>> +
>>> +	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
>>> +		erofs_err("unknown compression format %u for nid %llu",
>>> +			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
>>> +	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
>>> +	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
>>> +	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
>>> +		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
>>> +			  vi->nid * 1ULL);
>>> +		return -EFSCORRUPTED;
>>> +	}
>>> +
>>> +	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
>>> +		struct erofs_map_blocks map = { .index = UINT_MAX };
>>> +
>>> +		vi->idata_size = le16_to_cpu(h->h_idata_size);
>>> +		ret = z_erofs_do_map_blocks(vi, &map,
>>> +					    EROFS_GET_BLOCKS_FINDTAIL);
>>> +		if (!map.m_plen ||
>>> +		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
>>> +			erofs_err("invalid tail-packing pclustersize %llu",
>>> +				  map.m_plen | 0ULL);
>>> +			return -EFSCORRUPTED;
>>> +		}
>>> +		if (ret < 0)
>>> +			return ret;
>>> +	}
>>> +	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
>>> +	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
>>> +		struct erofs_map_blocks map = { .index = UINT_MAX };
>>> +
>>> +		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
>>> +		ret = z_erofs_do_map_blocks(vi, &map,
>>> +					    EROFS_GET_BLOCKS_FINDTAIL);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +	}
>>> +out:
>>> +	vi->flags |= EROFS_I_Z_INITED;
>>> +	return 0;
>>> +}
>>> +
>>>    int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>>>    			    struct erofs_map_blocks *map,
>>>    			    int flags)
