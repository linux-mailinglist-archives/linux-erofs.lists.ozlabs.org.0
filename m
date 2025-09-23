Return-Path: <linux-erofs+bounces-1062-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3405FB93F5A
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 04:09:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW3MH00ktz3cYN;
	Tue, 23 Sep 2025 12:09:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758593370;
	cv=none; b=Yd4GJkjfGZi3ZfHC2bds67oaF8gZGQ9FhHMWmJJzC9IS7LwIssT28oAYsEnyM3Y2N75Ss0ttvfX7lAynvCOEBAFTUezxyLcIhQO4Qf5B704H0lyNNsR/vobKq89BjidiIrxJyBY/ZHILTA+ysCInh1OR/Jd3pNNmaVFD5x17RA955bg9b8y5CevrYEjXCtjuAbH1WKUM+y7JphCHbFNT6v/ALtsKKxm6pXRA7t4VlL9ezda/ncyyORIIMtsHEY1Wjz1DIiNG6xcXEElVKCiAh2xOFaDjAoIbGds+7M92TsB6HHBapM8FQWVaNS7ir6CLLPFc6pmR7TPXDFRrF2mZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758593370; c=relaxed/relaxed;
	bh=8UFdBtUM1tjbXJvNs2hlz5aplHcQLW9Q43Hy1beDqoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz1pRo2KTLCtS+SKBckpqS/SoGK+be2veM1ZABar7IVfAUe7vPmaKa/OqTprdOl8uZk4zzkbObzWl4K6LKJclHEthnwW5qv3TVDlADXaVUlQFAX9ctmuEGLxBGNbmKZ3TsORFlS7j3ZXd//B5uQ4Fk/zyOo8RXeGEJWhPSHUiNaomfgHGwA24swH3YA9CPOUO5BGsBBvL+WK21II1L7n7OaxIAWslcY7pPHMM/LeydH4WLKwpbbImwajbCHQFA3sd3Wo2V5SOt4rAxRjK9YE/T+uk5+x4I2Q4SjRu6gyG7b2oCVG21m2sb8O53xmnnV8Zu9zu+yduEbhEyhSP2iIow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BgjZISx6; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BgjZISx6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW3MD5FSSz2yqq
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 12:09:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758593369; x=1790129369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g7DmpIPs15UHBB9LtMIq6t6tGz0g4/OwnNpVLGfrMDs=;
  b=BgjZISx6b7FTQ3XBaww+nBzhydRtqbmC5PkDkyjtFKI9SoIZwg9SORYz
   clh0jdOz1/nxvOBDe7AiJfapqV+vhyzNVSMJTliD+prFM4NzAa4tcKP3N
   PBzxoAhEU+YsjBDEQHNwIcvENyEnrMpZPBiWnsrd4ug5Cl24bmSrmb1XH
   ySflHptTNetISz5AmYIIFciHovcyhdUX34/354HtEMyjqjT/8WRi83x4r
   7BtMh1wzQ4cHQ0P5Nm/AW3Ir4RKUr5RQaIc70Af5TpN/4iIGyGp+SEiw+
   WpA1R3ZVIiNndMag5dsr6gHijAyJ4gQ2QEpA+5SkrQiXV6mtqKulLBMsB
   Q==;
X-CSE-ConnectionGUID: mmzst9oeSoeqyXQLqsntfg==
X-CSE-MsgGUID: s5w/a5e0Sqyb5tYYqpP0sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60780565"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60780565"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 19:09:22 -0700
X-CSE-ConnectionGUID: sorZ0l60T5WHS+bcQyMbHQ==
X-CSE-MsgGUID: 2X2TVSbzRm+e8OQWXwzEVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="180632784"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Sep 2025 19:09:19 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0sSz-0002ef-06;
	Tue, 23 Sep 2025 02:09:17 +0000
Date: Tue, 23 Sep 2025 10:08:45 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: add direct I/O support for compressed data
Message-ID: <202509231206.6HNck2h0-lkp@intel.com>
References: <20250922124304.489419-1-guochunhai@vivo.com>
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
In-Reply-To: <20250922124304.489419-1-guochunhai@vivo.com>
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chunhai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xiang-erofs/dev-test]
[also build test WARNING on xiang-erofs/dev xiang-erofs/fixes linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-add-direct-I-O-support-for-compressed-data/20250922-204843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250922124304.489419-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: add direct I/O support for compressed data
config: loongarch-randconfig-r072-20250923 (https://download.01.org/0day-ci/archive/20250923/202509231206.6HNck2h0-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231206.6HNck2h0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231206.6HNck2h0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/erofs/zdata.c:2069:6: warning: variable 'tmp_cnt' set but not used [-Wunused-but-set-variable]
    2069 |         int tmp_cnt = 0;
         |             ^
   1 warning generated.


vim +/tmp_cnt +2069 fs/erofs/zdata.c

  2056	
  2057	static ssize_t z_erofs_dio_read_iter(struct kiocb *iocb, struct iov_iter *iter)
  2058	{
  2059		struct inode *inode = file_inode(iocb->ki_filp);
  2060		Z_EROFS_DEFINE_FRONTEND(f, inode, iocb->ki_pos);
  2061		ssize_t err, off0;
  2062		loff_t offset = iocb->ki_pos;
  2063		unsigned int i = 0, total_pages, nr_pages = 0;
  2064		struct folio *head = NULL, *folio;
  2065		struct dio_erofs dio;
  2066		struct page **pages;
  2067		loff_t i_size;
  2068		struct iov_iter iter_saved = *iter;
> 2069		int tmp_cnt = 0;
  2070	
  2071		if (!iov_iter_count(iter))
  2072			return 0;
  2073	
  2074		i_size = i_size_read(inode);
  2075		if (offset >= i_size)
  2076			return 0;
  2077	
  2078		memset(&dio, 0, offsetof(struct dio_erofs, pages));
  2079		atomic_set(&dio.ref, 1);
  2080		dio.should_dirty = user_backed_iter(iter) && iov_iter_rw(iter) == READ;
  2081		dio.iocb = iocb;
  2082		dio.pos = ALIGN(min(iocb->ki_pos + (loff_t)iov_iter_count(iter),
  2083					i_size), PAGE_SIZE);
  2084		dio.is_pinned = iov_iter_extract_will_pin(iter);
  2085		dio.waiter = current;
  2086		f.dio = &dio;
  2087		iter_saved = *iter;
  2088		inode_dio_begin(inode);
  2089		pages = dio.pages;
  2090		total_pages = DIV_ROUND_UP(dio.pos - iocb->ki_pos, PAGE_SIZE);
  2091		for (; total_pages > 0; total_pages -= nr_pages) {
  2092			err = iov_iter_extract_pages(iter, &pages, LONG_MAX,
  2093					min(ARRAY_SIZE(dio.pages), total_pages), 0,
  2094					&off0);
  2095			if (err <= 0) {
  2096				err = -EFAULT;
  2097				goto fail_dio;
  2098			}
  2099			DBG_BUGON(off0);
  2100			iov_iter_revert(iter, err & ~PAGE_MASK);
  2101			nr_pages = DIV_ROUND_UP(err, PAGE_SIZE);
  2102			tmp_cnt += nr_pages;
  2103			for (i = 0; i < nr_pages; i++) {
  2104				folio = page_folio(pages[i]);
  2105				if (folio_test_large(folio) ||
  2106						folio_test_private(folio)) {
  2107					err = -EFAULT;
  2108					goto fail_dio;
  2109				}
  2110				folio->private = head;
  2111				head = folio;
  2112			}
  2113		}
  2114	
  2115		z_erofs_pcluster_readmore(&f, NULL, true);
  2116		while (head) {
  2117			folio = head;
  2118			head = folio_get_private(folio);
  2119			dio.pos -= folio_size(folio);
  2120			err = z_erofs_scan_folio(&f, folio, false);
  2121			if (err && err != -EINTR)
  2122				erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
  2123					  folio->index, EROFS_I(inode)->nid);
  2124		}
  2125		z_erofs_pcluster_end(&f);
  2126	
  2127		err = z_erofs_runqueue(&f, 0);
  2128		erofs_put_metabuf(&f.map.buf);
  2129		erofs_release_pages(&f.pagepool);
  2130	
  2131		if (!atomic_dec_and_test(&dio.ref)) {
  2132			for (;;) {
  2133				set_current_state(TASK_UNINTERRUPTIBLE);
  2134				if (!READ_ONCE(dio.waiter))
  2135					break;
  2136	
  2137				blk_io_schedule();
  2138			}
  2139			__set_current_state(TASK_RUNNING);
  2140		}
  2141	
  2142		err = err ?: dio.eio;
  2143		if (likely(!err)) {
  2144			err = dio.size;
  2145			if (offset + dio.size > i_size) /* check for short read */
  2146				err = i_size - offset;
  2147			iocb->ki_pos += err;
  2148		}
  2149		inode_dio_end(inode);
  2150		return err;
  2151	
  2152	fail_dio:
  2153		if (dio.is_pinned) {
  2154			while (head) {
  2155				folio = head;
  2156				head = folio_get_private(folio);
  2157				unpin_user_page(folio_page(folio, 0));
  2158			}
  2159			for (; i < nr_pages; i++)
  2160				unpin_user_page(dio.pages[i]);
  2161		}
  2162		*iter = iter_saved;
  2163		return err;
  2164	}
  2165	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

