Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B69689DA3
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 16:13:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7fLJ3K7fz3f5h
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Feb 2023 02:13:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HKf7Vjeo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HKf7Vjeo;
	dkim-atps=neutral
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7fL923Chz3bZj
	for <linux-erofs@lists.ozlabs.org>; Sat,  4 Feb 2023 02:13:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675437201; x=1706973201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+qhJGcdQMX1iSW34SbhRnsrfh1meYsJgBSEcMcY+h0U=;
  b=HKf7VjeoLrZQCGllagGJeHpBsSXRTtJE4io7LNGF8On/4yzxHE+tGFah
   cARZ3lndSVjlQlVf5e1n6o3gQsAiVzqrimNPbfKBSUpo14EJodiMNG9O9
   +EXC3iKkdmc6qVZv6Wh80g/Zt+UkukXqDsUQawoJmRLNHqOuB3Qvs8as8
   lss5w+UHLAm5tMmGdWuzSbfaTxpE8A5++LYSflpkxz62Wa7511R69pSSx
   DbGJSdnzM/hV4x+3l00lCmo0/KrvAxOVg/KO1lprxlPG5UlySdnVCriF5
   LApzdEbypPldxI5UdKUrskXnEgD+sRZgsSbb6UgPGOLXhISaUgt905y4G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="414978556"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="414978556"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:13:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="789722313"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="789722313"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Feb 2023 07:13:10 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pNxkO-0000aZ-18;
	Fri, 03 Feb 2023 15:13:04 +0000
Date: Fri, 3 Feb 2023 23:12:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v3 7/9] erofs: implement .mmap for page cache sharing
Message-ID: <202302032301.KaFzWF1g-lkp@intel.com>
References: <20230203030143.73105-8-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203030143.73105-8-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jingbo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xiang-erofs/dev-test]
[also build test WARNING on xiang-erofs/dev xiang-erofs/fixes linus/master v6.2-rc6 next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbo-Xu/erofs-support-readahead-in-meta-routine/20230203-110255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20230203030143.73105-8-jefflexu%40linux.alibaba.com
patch subject: [PATCH v3 7/9] erofs: implement .mmap for page cache sharing
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230203/202302032301.KaFzWF1g-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/499758ba5c442083b32a76a3fd55b734df0c486b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jingbo-Xu/erofs-support-readahead-in-meta-routine/20230203-110255
        git checkout 499758ba5c442083b32a76a3fd55b734df0c486b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/erofs/fscache.c:435:12: warning: no previous prototype for 'erofs_fscache_share_fault' [-Wmissing-prototypes]
     435 | vm_fault_t erofs_fscache_share_fault(struct vm_fault *vmf)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/erofs_fscache_share_fault +435 fs/erofs/fscache.c

   434	
 > 435	vm_fault_t erofs_fscache_share_fault(struct vm_fault *vmf)
   436	{
   437		struct erofs_fscache_finfo *finfo = vmf->vma->vm_file->private_data;
   438	
   439		if (unlikely(vmf->pgoff >= finfo->max_idx))
   440			return VM_FAULT_SIGBUS;
   441		return filemap_fault(vmf);
   442	}
   443	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
