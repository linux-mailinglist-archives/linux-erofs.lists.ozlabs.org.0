Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4F4D2DC4
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Mar 2022 12:16:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KD8l21TbVz2yws
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Mar 2022 22:15:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KD8kw2TVxz2ywb
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Mar 2022 22:15:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V6jihDJ_1646824537; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6jihDJ_1646824537) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 19:15:38 +0800
Date: Wed, 9 Mar 2022 19:15:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: fs/erofs/zmap.c:394 z_erofs_get_extent_compressedlen() warn:
 should '1 << lclusterbits' be a 64 bit type?
Message-ID: <YiiMWCZS7bzeAFme@B-P7TQMD6M-0146.local>
References: <202203091002.lJVzsX6e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202203091002.lJVzsX6e-lkp@intel.com>
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
Cc: kbuild-all@lists.01.org, kbuild@lists.01.org, linux-erofs@lists.ozlabs.org,
 lkp@intel.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

On Wed, Mar 09, 2022 at 01:27:08PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   92f90cc9fe0e7a984ea3d4bf3d120e30ba8a2118
> commit: cec6e93beadfd145758af2c0854fcc2abb8170cb erofs: support parsing big pcluster compress indexes
> config: i386-randconfig-m021-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091002.lJVzsX6e-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> fs/erofs/zmap.c:394 z_erofs_get_extent_compressedlen() warn: should '1 << lclusterbits' be a 64 bit type?
> fs/erofs/zmap.c:423 z_erofs_get_extent_compressedlen() warn: should 'm->compressedlcs << lclusterbits' be a 64 bit type?
> 
> vim +394 fs/erofs/zmap.c
> 
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  381  static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  382  					    unsigned int initial_lcn)
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  383  {
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  384  	struct erofs_inode *const vi = EROFS_I(m->inode);
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  385  	struct erofs_map_blocks *const map = m->map;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  386  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  387  	unsigned long lcn;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  388  	int err;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  389  
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  390  	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  391  		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  392  	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  393  	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07 @394  		map->m_plen = 1 << lclusterbits;
> 
> 1ULL << lclusterbits?

Thanks for the report!

In practice, m_plen won't be larger than 1MiB due to on-disk constraint
for compression mode, so we're always safe here. m_plen only can be
larger than 4GiB for non-compression mode.

Yet we could update this on the static analysis side, I will submit a
patch later.

> 
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  395  		return 0;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  396  	}
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  397  
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  398  	lcn = m->lcn + 1;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  399  	if (m->compressedlcs)
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  400  		goto out;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  401  	if (lcn == initial_lcn)
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  402  		goto err_bonus_cblkcnt;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  403  
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  404  	err = z_erofs_load_cluster_from_disk(m, lcn);
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  405  	if (err)
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  406  		return err;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  407  
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  408  	switch (m->type) {
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  409  	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  410  		if (m->delta[0] != 1)
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  411  			goto err_bonus_cblkcnt;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  412  		if (m->compressedlcs)
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  413  			break;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  414  		fallthrough;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  415  	default:
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  416  		erofs_err(m->inode->i_sb,
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  417  			  "cannot found CBLKCNT @ lcn %lu of nid %llu",
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  418  			  lcn, vi->nid);
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  419  		DBG_BUGON(1);
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  420  		return -EFSCORRUPTED;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  421  	}
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  422  out:
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07 @423  	map->m_plen = m->compressedlcs << lclusterbits;
> 
> Same thing here.

Ditto.

Thanks,
Gao Xiang

> 
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  424  	return 0;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  425  err_bonus_cblkcnt:
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  426  	erofs_err(m->inode->i_sb,
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  427  		  "bogus CBLKCNT @ lcn %lu of nid %llu",
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  428  		  lcn, vi->nid);
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  429  	DBG_BUGON(1);
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  430  	return -EFSCORRUPTED;
> cec6e93beadfd1 fs/erofs/zmap.c              Gao Xiang 2021-04-07  431  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
