Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1649E488
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 11:37:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HkLD1W8YzDqdw
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 19:37:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HkL835gNzDqYS
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2019 19:37:19 +1000 (AEST)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id C02335AB6A82348D17C6;
 Tue, 27 Aug 2019 17:37:14 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 27 Aug 2019 17:37:14 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 27 Aug 2019 17:37:14 +0800
Date: Tue, 27 Aug 2019 17:36:29 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] staging: erofs: tidy up decompression frontend
Message-ID: <20190827093629.GA55193@architecture4>
References: <20190827090355.GA29280@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190827090355.GA29280@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

Thanks for your report.

On Tue, Aug 27, 2019 at 12:03:55PM +0300, Dan Carpenter wrote:
> Hello Gao Xiang,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 97e86a858bc3: "staging: erofs: tidy up decompression
> frontend" from Jul 31, 2019, leads to the following Smatch complaint:
> 
>     fs/erofs/zdata.c:670 z_erofs_do_read_page()
>     error: we previously assumed 'clt->cl' could be null (see line 596)
> 
> fs/erofs/zdata.c
>    595			/* didn't get a valid collection previously (very rare) */
>    596			if (!clt->cl)
>                             ^^^^^^^^
> New NULL check.
> 
>    597				goto restart_now;
>    598			goto hitted;
>    599		}
>    600	
>    601		/* go ahead the next map_blocks */
>    602		debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
>    603	
>    604		if (z_erofs_collector_end(clt))
>    605			fe->backmost = false;
>    606	
>    607		map->m_la = offset + cur;
>    608		map->m_llen = 0;
>    609		err = z_erofs_map_blocks_iter(inode, map, 0);
>    610		if (unlikely(err))
>    611			goto err_out;
>    612	
>    613	restart_now:
>    614		if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
>    615			goto hitted;
>    616	
>    617		err = z_erofs_collector_begin(clt, inode, map);

At a glance, clt->cl will be all initialized in all successful paths
in z_erofs_collector_begin, or it all fall back into err_out...
I have no idea what is wrong here...

Some detailed path from Smatch for NIL dereferences?

Thanks,
Gao Xiang

>    618		if (unlikely(err))
>    619			goto err_out;
>    620	
>    621		/* preload all compressed pages (maybe downgrade role if necessary) */
>    622		if (should_alloc_managed_pages(fe, sbi->cache_strategy, map->m_la))
>    623			cache_strategy = DELAYEDALLOC;
>    624		else
>    625			cache_strategy = DONTALLOC;
>    626	
>    627		preload_compressed_pages(clt, MNGD_MAPPING(sbi),
>    628					 cache_strategy, pagepool);
>    629	
>    630		tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED);
>    631	hitted:
>    632		cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>    633		if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED))) {
>    634			zero_user_segment(page, cur, end);
>    635			goto next_part;
>    636		}
>    637	
>    638		/* let's derive page type */
>    639		page_type = cur ? Z_EROFS_VLE_PAGE_TYPE_HEAD :
>    640			(!spiltted ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
>    641				(tight ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
>    642					Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED));
>    643	
>    644		if (cur)
>    645			tight &= (clt->mode >= COLLECT_PRIMARY_FOLLOWED);
>    646	
>    647	retry:
>    648		err = z_erofs_attach_page(clt, page, page_type);
>    649		/* should allocate an additional staging page for pagevec */
>    650		if (err == -EAGAIN) {
>    651			struct page *const newpage =
>    652				__stagingpage_alloc(pagepool, GFP_NOFS);
>    653	
>    654			err = z_erofs_attach_page(clt, newpage,
>    655						  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
>    656			if (likely(!err))
>    657				goto retry;
>    658		}
>    659	
>    660		if (unlikely(err))
>    661			goto err_out;
>    662	
>    663		index = page->index - (map->m_la >> PAGE_SHIFT);
>    664	
>    665		z_erofs_onlinepage_fixup(page, index, true);
>    666	
>    667		/* bump up the number of spiltted parts of a page */
>    668		++spiltted;
>    669		/* also update nr_pages */
>    670		clt->cl->nr_pages = max_t(pgoff_t, clt->cl->nr_pages, index + 1);
>                 ^^^^^^^^^^^^^^^^^                  ^^^^^^^^^^^^^^^^^
> Unchecked dereferences.
> 
>    671	next_part:
>    672		/* can be used for verification */
> 
> regards,
> dan carpenter
