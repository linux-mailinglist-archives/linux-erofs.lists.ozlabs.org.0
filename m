Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D23318FFD19
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 09:30:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fGFkV1I/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VwXsM5VHSz3bs2
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 17:29:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fGFkV1I/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VwXsD1rzPz30T3
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Jun 2024 17:29:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717745393; x=1749281393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2zqhKlVxrz3mbaDx+3zFhoMg3wKeoW+Xa3Fjl4ex1ps=;
  b=fGFkV1I/6MX+434PvFoAv3qInnvwLt24JTfe1a5lBykVpYgn09PZ0G+u
   Rx6BPG5S9zcdO0LBQz17lcT7rXcNYFznI/ItvE+XkEnsZVXEhe2lVor+e
   YUqzVVovHaiqaVac1JLPvcyqO8TYxvP8a1naIPUDip4G39vwXWaoKTHlT
   Bi1Rh036cNwAmhVRrg2oqUMLSty/Rhd17oASdAAtV2HT0qrN+y3bnXRZb
   734JM1LyYmCYVf8zAgayXKoEH31Vi+iqjzLIvEGecslnN5K36QPoI2ZFV
   lTVjmnbUdG1Va9Wk0lNiBd+Z3xcvByt4i95Dxas4BO1hnaT3woSiMCT1j
   g==;
X-CSE-ConnectionGUID: QhThWK3TRW2X89EFImhU0w==
X-CSE-MsgGUID: AMlwBn3bQkWO0Ww7PHIo9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14634928"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14634928"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 00:29:41 -0700
X-CSE-ConnectionGUID: dhQ+h4aLSba7BzGhhFJOzQ==
X-CSE-MsgGUID: LkN6+gQpQWOYS9MWDiSS/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="75713087"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Jun 2024 00:29:37 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFU2X-0004D9-2b;
	Fri, 07 Jun 2024 07:29:33 +0000
Date: Fri, 7 Jun 2024 15:29:17 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Zeng via B4 Relay <devnull+tao.zeng.amlogic.com@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <yuchao0@huawei.com>,
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH] erofs: support external crypto for decompression
Message-ID: <202406071506.XHwo54ej-lkp@intel.com>
References: <20240606-erofs-decompression-v1-1-ec5f31396e04@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-erofs-decompression-v1-1-ec5f31396e04@amlogic.com>
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
Cc: Tao Zeng <tao.zeng@amlogic.com>, llvm@lists.linux.dev, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tao,

kernel test robot noticed the following build errors:

[auto build test ERROR on ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Zeng-via-B4-Relay/erofs-support-external-crypto-for-decompression/20240606-155702
base:   ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
patch link:    https://lore.kernel.org/r/20240606-erofs-decompression-v1-1-ec5f31396e04%40amlogic.com
patch subject: [PATCH] erofs: support external crypto for decompression
config: arm64-randconfig-004-20240607 (https://download.01.org/0day-ci/archive/20240607/202406071506.XHwo54ej-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406071506.XHwo54ej-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406071506.XHwo54ej-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/erofs/zdata.c:7:
   In file included from fs/erofs/compress.h:9:
   In file included from fs/erofs/internal.h:11:
   In file included from include/linux/dax.h:6:
   In file included from include/linux/mm.h:2241:
   include/linux/vmstat.h:484:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     484 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     485 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:491:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     491 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     492 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:498:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     498 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:512:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     512 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     513 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/erofs/zdata.c:7:
>> fs/erofs/compress.h:120:1: error: expected identifier or '('
     120 | {
         | ^
   5 warnings and 1 error generated.


vim +120 fs/erofs/compress.h

   115	
   116	static inline int z_erofs_load_crypto_config(struct super_block *sb,
   117						     struct erofs_super_block *dsb,
   118						     void *data,
   119						     int size);
 > 120	{
   121		if (crypto) {
   122			erofs_err(sb, "crypto algorithm isn't enabled");
   123			return -EINVAL;
   124		}
   125		return 0;
   126	}
   127	#endif
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
