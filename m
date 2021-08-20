Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC23F2940
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 11:33:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Grbzw4cBZz3bNq
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 19:33:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grbzq3C9Xz2xZH
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 19:33:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R451e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UkJoTcw_1629452002; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UkJoTcw_1629452002) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 20 Aug 2021 17:33:23 +0800
Date: Fri, 20 Aug 2021 17:33:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 2/2] erofs: support reading chunk-based uncompressed
 files
Message-ID: <YR924TIIgLzJx0Ok@B-P7TQMD6M-0146.local>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-2-hsiangkao@linux.alibaba.com>
 <aaf64137-02f9-db98-10d4-4757bc6f25ec@kernel.org>
 <YR9x7W4wObWdZdrx@B-P7TQMD6M-0146.local>
 <f501144f-f7fc-1150-0c41-4c1981bd0594@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f501144f-f7fc-1150-0c41-4c1981bd0594@kernel.org>
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
Cc: Tao Ma <boyu.mt@taobao.com>, LKML <linux-kernel@vger.kernel.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Eryu Guan <eguan@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 20, 2021 at 05:29:36PM +0800, Chao Yu wrote:
> On 2021/8/20 17:12, Gao Xiang wrote:
> > Hi Chao,
> > 
> > On Fri, Aug 20, 2021 at 05:04:13PM +0800, Chao Yu wrote:
> > > On 2021/8/19 14:33, Gao Xiang wrote:
> > 
> > ...
> > 
> > > >    }
> > > > +static int erofs_map_blocks(struct inode *inode,
> > > > +			    struct erofs_map_blocks *map, int flags)
> > > > +{
> > > > +	struct super_block *sb = inode->i_sb;
> > > > +	struct erofs_inode *vi = EROFS_I(inode);
> > > > +	struct erofs_inode_chunk_index *idx;
> > > > +	struct page *page;
> > > > +	u64 chunknr;
> > > > +	unsigned int unit;
> > > > +	erofs_off_t pos;
> > > > +	int err = 0;
> > > > +
> > > > +	if (map->m_la >= inode->i_size) {
> > > > +		/* leave out-of-bound access unmapped */
> > > > +		map->m_flags = 0;
> > > > +		map->m_plen = 0;
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
> > > > +		return erofs_map_blocks_flatmode(inode, map, flags);
> > > > +
> > > > +	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
> > > > +		unit = sizeof(*idx);	/* chunk index */
> > > > +	else
> > > > +		unit = 4;		/* block map */
> > > 
> > > You mean sizeof(__le32)?
> > 
> > Yeah, sizeof(__le32) == 4, either way works for me.
> > 
> > If some tendency about this, I will update when applying.
> 
> Xiang,
> 
> Yeah, I preper:
> 
> #define EROFS_BLOCK_MAP_ENTRY_SIZE	sizeof(__le32)
> 
> 	unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
> 
> to improve readablity, but unit = sizeof(__le32) is fine as well.

Ok, looks much better, let me revise v3 here.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > > 
> > > Otherwise it looks good to me.
> > > 
> > > Reviewed-by: Chao Yu <chao@kernel.org>
> > > 
> > 
> > Thanks for the review!
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > Thanks,
> > > 
