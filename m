Return-Path: <linux-erofs+bounces-643-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD088B07FC9
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 23:41:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bj8dd5QDgz3bb2;
	Thu, 17 Jul 2025 07:41:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752702101;
	cv=none; b=fqoVhvs0RqzQhmuIUyG+q6JJXeWJS7RNWfCLLHraBGDZrODrRwQu8d6JK0/DZ6PRxLXutR+YhQnSB3j9+5EklwSinaEdHxc30YfRpiVDbUbQPb0xjnMDzRbIaNfGlv9UmvC4uXfHsPZ3hJqmp0Rqs32H+3M6tOtmVZdTA2nQMlYk07R3VTXoquYp6cu3sqvAIM1dqnceZJHms8ffJaw8ioLQDtZ4NbeUAVgK8oAq3zO6tzbMRoRJgUwvcrL+iu3rtPtHM50h6xFDDKjY+n1Rtip8Cis0yVT1QhcZc2W1sM3WtQh5wjY41FuaVf8lsttZbXOsKXTzHm2NiIiuEUxjog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752702101; c=relaxed/relaxed;
	bh=gBEwlkP+Bc6krFxNXH1k7+w+KsMB1v8WMDgiUL+F8eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E8nTcziguAfRZWjxR6zI40GMAd/x7L87n6mNazDAedTPllT8Ph5Ps/7aSVqDRv1huWL69Ljfl/gVZDXKnDxLkgLfrowvL7Ly+sreUvb3Y2LgBd4ueMo67KnggNkFW8Loywy2GSvme1mZ1PFgd9z2jgGDtNaaWNBGevRFPNgtjwRQUAJLF4UrnTUtTEvEa9w1v/P7iGyPwu1CGlBtT/kbag64KKjCBb93WGU0yRDnn3vGWQlgJxwe8q/4UD5U7MrXNnSqkzjzx11voDU2zwwRJNrwccLoOrwiJkbc6tg2rMaAnrVTosJ4PLyHQEKkoySgJJtLmu67+ZobDNednsN3/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zg/36ZLy; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zg/36ZLy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bj8db4QlTz30Vn
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 07:41:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752702100; x=1784238100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bPyWDybtxiIXDsQOutP6Ugd1kU7Qh/rouJ5vJEPlErs=;
  b=Zg/36ZLyEfVGi2OaFzfmXwWuyVBybLxAXRok4AVH8oht+37PbiToaqjw
   tmBPEoquQCm/4d9R8vY/NpntYZ4iRTWGk5QVgjZcSc9OfPGaGxpudtpUh
   2sPpX+65IdSg6JFqDS0MF91uhKC84jrXiCoi1UFG373D30+2yB7PWq9ZM
   M2PmS/ZKl7h6ng82sCOuYak76bvYzEb+QR88FnHMpYdaJna3C7m8okNoD
   Yi8DjE7ZY1krWTdH0rqN0ZQccGAitqMnkg0M6dvWNXHDxrMD29CkdEZLI
   FHbDQd/Jc4K8N7J80zeWtHE4MbMHyQcLpCiLoWf65lsb52uMXHuEeFE5e
   g==;
X-CSE-ConnectionGUID: A6jMGOZiTVe0aGRvphTaTw==
X-CSE-MsgGUID: NqFYmHE8QsO3jcrrgVl9LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58734941"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="58734941"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 14:41:34 -0700
X-CSE-ConnectionGUID: 4RulU/OFTRSkXVR8hV9XWg==
X-CSE-MsgGUID: Ge0fdliISNSKia8q3XHLSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157285489"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jul 2025 14:41:32 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc9sY-000Cs9-26;
	Wed, 16 Jul 2025 21:41:30 +0000
Date: Thu, 17 Jul 2025 05:40:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>
Cc: oe-kbuild-all@lists.linux.dev, Xiang Gao <xiang@kernel.org>,
	linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test 7/7] fs/erofs/fscache.c:277:23: error: too few
 arguments to function 'erofs_read_metabuf'; expected 4, have 3
Message-ID: <202507170548.rvm67YSU-lkp@intel.com>
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   33656c801bc94615e8b02f01f36eff752dc5086b
commit: 33656c801bc94615e8b02f01f36eff752dc5086b [7/7] erofs: implement metadata compression
config: arc-randconfig-002-20250717 (https://download.01.org/0day-ci/archive/20250717/202507170548.rvm67YSU-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507170548.rvm67YSU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507170548.rvm67YSU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/bits.h:6,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/vfsdebug.h:5,
                    from include/linux/fs.h:5,
                    from fs/erofs/internal.h:10,
                    from fs/erofs/xattr.h:9,
                    from fs/erofs/inode.c:7:
   fs/erofs/internal.h: In function 'erofs_inode_in_metabox':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/erofs/internal.h:288:38: note: in expansion of macro 'BIT'
     288 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
         |                                      ^~~
   fs/erofs/internal.h: In function 'erofs_iloc':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/erofs/erofs_fs.h:275:42: note: in expansion of macro 'BIT'
     275 | #define EROFS_DIRENT_NID_MASK           (BIT(EROFS_DIRENT_NID_METABOX_BIT) - 1)
         |                                          ^~~
   fs/erofs/internal.h:294:52: note: in expansion of macro 'EROFS_DIRENT_NID_MASK'
     294 |         erofs_nid_t nid_lo = EROFS_I(inode)->nid & EROFS_DIRENT_NID_MASK;
         |                                                    ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/bits.h:6,
                    from include/linux/string_helpers.h:5,
                    from include/linux/seq_file.h:7,
                    from fs/erofs/super.c:8:
   fs/erofs/internal.h: In function 'erofs_inode_in_metabox':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/erofs/internal.h:288:38: note: in expansion of macro 'BIT'
     288 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
         |                                      ^~~
   fs/erofs/internal.h: In function 'erofs_iloc':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/erofs/erofs_fs.h:275:42: note: in expansion of macro 'BIT'
     275 | #define EROFS_DIRENT_NID_MASK           (BIT(EROFS_DIRENT_NID_METABOX_BIT) - 1)
         |                                          ^~~
   fs/erofs/internal.h:294:52: note: in expansion of macro 'EROFS_DIRENT_NID_MASK'
     294 |         erofs_nid_t nid_lo = EROFS_I(inode)->nid & EROFS_DIRENT_NID_MASK;
         |                                                    ^~~~~~~~~~~~~~~~~~~~~
   fs/erofs/super.c: In function 'erofs_read_superblock':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/erofs/super.c:327:40: note: in expansion of macro 'BIT'
     327 |                 if (sbi->metabox_nid & BIT(EROFS_DIRENT_NID_METABOX_BIT))
         |                                        ^~~
--
   In file included from include/linux/bits.h:6,
                    from include/linux/bitops.h:6,
                    from include/linux/kernel.h:23,
                    from include/linux/fs_context.h:11,
                    from include/linux/pseudo_fs.h:4,
                    from fs/erofs/fscache.c:6:
   fs/erofs/internal.h: In function 'erofs_inode_in_metabox':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/erofs/internal.h:288:38: note: in expansion of macro 'BIT'
     288 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
         |                                      ^~~
   fs/erofs/internal.h: In function 'erofs_iloc':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   fs/erofs/erofs_fs.h:275:42: note: in expansion of macro 'BIT'
     275 | #define EROFS_DIRENT_NID_MASK           (BIT(EROFS_DIRENT_NID_METABOX_BIT) - 1)
         |                                          ^~~
   fs/erofs/internal.h:294:52: note: in expansion of macro 'EROFS_DIRENT_NID_MASK'
     294 |         erofs_nid_t nid_lo = EROFS_I(inode)->nid & EROFS_DIRENT_NID_MASK;
         |                                                    ^~~~~~~~~~~~~~~~~~~~~
   fs/erofs/fscache.c: In function 'erofs_fscache_data_read_slice':
>> fs/erofs/fscache.c:277:23: error: too few arguments to function 'erofs_read_metabuf'; expected 4, have 3
     277 |                 src = erofs_read_metabuf(&buf, sb, map.m_pa);
         |                       ^~~~~~~~~~~~~~~~~~
   In file included from fs/erofs/fscache.c:8:
   fs/erofs/internal.h:400:7: note: declared here
     400 | void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
         |       ^~~~~~~~~~~~~~~~~~


vim +/erofs_read_metabuf +277 fs/erofs/fscache.c

5375e7c8b0fef1 Jeffle Xu 2022-04-25  253  
f2151df5743536 Jingbo Xu 2024-03-08  254  static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
bd735bdaa62fb6 Jeffle Xu 2022-04-25  255  {
f2151df5743536 Jingbo Xu 2024-03-08  256  	struct address_space *mapping = req->mapping;
1ae9470c3e1462 Jingbo Xu 2022-09-22  257  	struct inode *inode = mapping->host;
1ae9470c3e1462 Jingbo Xu 2022-09-22  258  	struct super_block *sb = inode->i_sb;
f2151df5743536 Jingbo Xu 2024-03-08  259  	struct erofs_fscache_io *io;
1ae9470c3e1462 Jingbo Xu 2022-09-22  260  	struct erofs_map_blocks map;
1ae9470c3e1462 Jingbo Xu 2022-09-22  261  	struct erofs_map_dev mdev;
f2151df5743536 Jingbo Xu 2024-03-08  262  	loff_t pos = req->start + req->submitted;
1ae9470c3e1462 Jingbo Xu 2022-09-22  263  	size_t count;
1ae9470c3e1462 Jingbo Xu 2022-09-22  264  	int ret;
1ae9470c3e1462 Jingbo Xu 2022-09-22  265  
1ae9470c3e1462 Jingbo Xu 2022-09-22  266  	map.m_la = pos;
8b58f9f0216212 Jingbo Xu 2023-02-09  267  	ret = erofs_map_blocks(inode, &map);
1ae9470c3e1462 Jingbo Xu 2022-09-22  268  	if (ret)
1ae9470c3e1462 Jingbo Xu 2022-09-22  269  		return ret;
1ae9470c3e1462 Jingbo Xu 2022-09-22  270  
1ae9470c3e1462 Jingbo Xu 2022-09-22  271  	if (map.m_flags & EROFS_MAP_META) {
bd735bdaa62fb6 Jeffle Xu 2022-04-25  272  		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
f2151df5743536 Jingbo Xu 2024-03-08  273  		struct iov_iter iter;
076d965eb812f2 Al Viro   2024-04-25  274  		size_t size = map.m_llen;
1ae9470c3e1462 Jingbo Xu 2022-09-22  275  		void *src;
bd735bdaa62fb6 Jeffle Xu 2022-04-25  276  
296e7ef18fbd6e Gao Xiang 2025-07-14 @277  		src = erofs_read_metabuf(&buf, sb, map.m_pa);
bd735bdaa62fb6 Jeffle Xu 2022-04-25  278  		if (IS_ERR(src))
bd735bdaa62fb6 Jeffle Xu 2022-04-25  279  			return PTR_ERR(src);
bd735bdaa62fb6 Jeffle Xu 2022-04-25  280  
de4eda9de2d957 Al Viro   2022-09-15  281  		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, PAGE_SIZE);
076d965eb812f2 Al Viro   2024-04-25  282  		if (copy_to_iter(src, size, &iter) != size) {
75e43355cbe4d5 Jingbo Xu 2022-11-04  283  			erofs_put_metabuf(&buf);
1ae9470c3e1462 Jingbo Xu 2022-09-22  284  			return -EFAULT;
75e43355cbe4d5 Jingbo Xu 2022-11-04  285  		}
1ae9470c3e1462 Jingbo Xu 2022-09-22  286  		iov_iter_zero(PAGE_SIZE - size, &iter);
bd735bdaa62fb6 Jeffle Xu 2022-04-25  287  		erofs_put_metabuf(&buf);
f2151df5743536 Jingbo Xu 2024-03-08  288  		req->submitted += PAGE_SIZE;
be62c519886115 Jingbo Xu 2022-12-01  289  		return 0;
bd735bdaa62fb6 Jeffle Xu 2022-04-25  290  	}
bd735bdaa62fb6 Jeffle Xu 2022-04-25  291  
f2151df5743536 Jingbo Xu 2024-03-08  292  	count = req->len - req->submitted;
1442b02b66ad2c Jeffle Xu 2022-04-25  293  	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
f2151df5743536 Jingbo Xu 2024-03-08  294  		struct iov_iter iter;
f2151df5743536 Jingbo Xu 2024-03-08  295  
de4eda9de2d957 Al Viro   2022-09-15  296  		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
1ae9470c3e1462 Jingbo Xu 2022-09-22  297  		iov_iter_zero(count, &iter);
f2151df5743536 Jingbo Xu 2024-03-08  298  		req->submitted += count;
be62c519886115 Jingbo Xu 2022-12-01  299  		return 0;
bd735bdaa62fb6 Jeffle Xu 2022-04-25  300  	}
bd735bdaa62fb6 Jeffle Xu 2022-04-25  301  
be62c519886115 Jingbo Xu 2022-12-01  302  	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
e6d9f9ba111b56 Jingbo Xu 2022-11-04  303  	DBG_BUGON(!count || count % PAGE_SIZE);
e6d9f9ba111b56 Jingbo Xu 2022-11-04  304  
1442b02b66ad2c Jeffle Xu 2022-04-25  305  	mdev = (struct erofs_map_dev) {
1442b02b66ad2c Jeffle Xu 2022-04-25  306  		.m_deviceid = map.m_deviceid,
1442b02b66ad2c Jeffle Xu 2022-04-25  307  		.m_pa = map.m_pa,
1442b02b66ad2c Jeffle Xu 2022-04-25  308  	};
1442b02b66ad2c Jeffle Xu 2022-04-25  309  	ret = erofs_map_dev(sb, &mdev);
1442b02b66ad2c Jeffle Xu 2022-04-25  310  	if (ret)
1ae9470c3e1462 Jingbo Xu 2022-09-22  311  		return ret;
1442b02b66ad2c Jeffle Xu 2022-04-25  312  
f2151df5743536 Jingbo Xu 2024-03-08  313  	io = erofs_fscache_req_io_alloc(req);
f2151df5743536 Jingbo Xu 2024-03-08  314  	if (!io)
f2151df5743536 Jingbo Xu 2024-03-08  315  		return -ENOMEM;
f2151df5743536 Jingbo Xu 2024-03-08  316  	iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
f8d920a402aec3 Gao Xiang 2024-12-13  317  	ret = erofs_fscache_read_io_async(mdev.m_dif->fscache->cookie,
f2151df5743536 Jingbo Xu 2024-03-08  318  			mdev.m_pa + (pos - map.m_la), io);
f2151df5743536 Jingbo Xu 2024-03-08  319  	erofs_fscache_req_io_put(io);
d435d53228dd03 Xin Yin   2022-05-09  320  
f2151df5743536 Jingbo Xu 2024-03-08  321  	req->submitted += count;
be62c519886115 Jingbo Xu 2022-12-01  322  	return ret;
5bd9628b784cc5 Sun Ke    2022-08-15  323  }
d435d53228dd03 Xin Yin   2022-05-09  324  

:::::: The code at line 277 was first introduced by commit
:::::: 296e7ef18fbd6e85c8660f0ec94358ac4263cd57 erofs: remove need_kmap in erofs_read_metabuf()

:::::: TO: Gao Xiang <hsiangkao@linux.alibaba.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

