Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F19E397
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 11:04:27 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Hjc70Gz3zDqvd
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 19:04:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="MJuBpJKj"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Hjbx5tr5zDqt0
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2019 19:04:12 +1000 (AEST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R93Zb5174278;
 Tue, 27 Aug 2019 09:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=AXbHuSlNAdI5bKuIK3j4yHiJU5GYkC8zm7kbQXmi5yQ=;
 b=MJuBpJKje3S0K5HqBGm1s6JPqGsMPsvwMJCb1tsCOaLoYLK8tKTayemkPD1uEIt6Wjzm
 eFPW3+OcoCJ2Z9om26oxjRNE6QTGnnlVfyp0Sqq2ieee5DN0s0b78Axpr/s47TGRzeX+
 OM272OdN/SNxSc8RhySJ0dQZD3N/1O4EIzSAGstHnOg0bkmXw+Ii+t9pWMZvG1nVemhJ
 cY9ZmBFJPpQGQKH0VXLZoGTE7CCZivu8r8xmIQS7Dpxg1C59lZVTETAjx1l15ZlKmFU0
 gg5AUN2Bv97gFx6tPP7vquwYFQjR/dwv9f9eytiWGJydcd02HGKm6zMWNbR2NMGtk0RX RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2un16y8b5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Aug 2019 09:04:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R93G3l171504;
 Tue, 27 Aug 2019 09:04:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2umj2ye5x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Aug 2019 09:04:05 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7R941cG002738;
 Tue, 27 Aug 2019 09:04:01 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 27 Aug 2019 02:04:01 -0700
Date: Tue, 27 Aug 2019 12:03:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: xiang@kernel.org
Subject: [bug report] staging: erofs: tidy up decompression frontend
Message-ID: <20190827090355.GA29280@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270102
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello Gao Xiang,

This is a semi-automatic email about new static checker warnings.

The patch 97e86a858bc3: "staging: erofs: tidy up decompression
frontend" from Jul 31, 2019, leads to the following Smatch complaint:

    fs/erofs/zdata.c:670 z_erofs_do_read_page()
    error: we previously assumed 'clt->cl' could be null (see line 596)

fs/erofs/zdata.c
   595			/* didn't get a valid collection previously (very rare) */
   596			if (!clt->cl)
                            ^^^^^^^^
New NULL check.

   597				goto restart_now;
   598			goto hitted;
   599		}
   600	
   601		/* go ahead the next map_blocks */
   602		debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
   603	
   604		if (z_erofs_collector_end(clt))
   605			fe->backmost = false;
   606	
   607		map->m_la = offset + cur;
   608		map->m_llen = 0;
   609		err = z_erofs_map_blocks_iter(inode, map, 0);
   610		if (unlikely(err))
   611			goto err_out;
   612	
   613	restart_now:
   614		if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
   615			goto hitted;
   616	
   617		err = z_erofs_collector_begin(clt, inode, map);
   618		if (unlikely(err))
   619			goto err_out;
   620	
   621		/* preload all compressed pages (maybe downgrade role if necessary) */
   622		if (should_alloc_managed_pages(fe, sbi->cache_strategy, map->m_la))
   623			cache_strategy = DELAYEDALLOC;
   624		else
   625			cache_strategy = DONTALLOC;
   626	
   627		preload_compressed_pages(clt, MNGD_MAPPING(sbi),
   628					 cache_strategy, pagepool);
   629	
   630		tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED);
   631	hitted:
   632		cur = end - min_t(unsigned int, offset + end - map->m_la, end);
   633		if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED))) {
   634			zero_user_segment(page, cur, end);
   635			goto next_part;
   636		}
   637	
   638		/* let's derive page type */
   639		page_type = cur ? Z_EROFS_VLE_PAGE_TYPE_HEAD :
   640			(!spiltted ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
   641				(tight ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
   642					Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED));
   643	
   644		if (cur)
   645			tight &= (clt->mode >= COLLECT_PRIMARY_FOLLOWED);
   646	
   647	retry:
   648		err = z_erofs_attach_page(clt, page, page_type);
   649		/* should allocate an additional staging page for pagevec */
   650		if (err == -EAGAIN) {
   651			struct page *const newpage =
   652				__stagingpage_alloc(pagepool, GFP_NOFS);
   653	
   654			err = z_erofs_attach_page(clt, newpage,
   655						  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
   656			if (likely(!err))
   657				goto retry;
   658		}
   659	
   660		if (unlikely(err))
   661			goto err_out;
   662	
   663		index = page->index - (map->m_la >> PAGE_SHIFT);
   664	
   665		z_erofs_onlinepage_fixup(page, index, true);
   666	
   667		/* bump up the number of spiltted parts of a page */
   668		++spiltted;
   669		/* also update nr_pages */
   670		clt->cl->nr_pages = max_t(pgoff_t, clt->cl->nr_pages, index + 1);
                ^^^^^^^^^^^^^^^^^                  ^^^^^^^^^^^^^^^^^
Unchecked dereferences.

   671	next_part:
   672		/* can be used for verification */

regards,
dan carpenter
