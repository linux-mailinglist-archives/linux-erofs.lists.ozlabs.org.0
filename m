Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5270969A492
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Feb 2023 04:50:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PHyWb31hwz3f2p
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Feb 2023 14:50:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GbMUt8zV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GbMUt8zV;
	dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PHyWR0zy6z3c8h
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Feb 2023 14:50:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676605811; x=1708141811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O+c6MjNUQXeadDzpM+t8VgVjrw7GBTRFLweCYRCA8HY=;
  b=GbMUt8zV221EKi36ikD9jDQPMnFNilfPR38u0FS8T+/mnDXpHN2GpCHZ
   xxvlguY5qmiaOv8B366igf9mTgMzCze6ebBAqqWkNmirxeJ5JF3CY6wfs
   /AeB9AO52iATOVE+h3tcktNB+SCdYhcrp22aSfnCP0HYLCejCpOi3xFKJ
   whw1ZAO2Zm2acRkjw/2mKd4oXXKgg0iUs/L6u8DZ4ca7zdjmsQoLUJm+R
   bOfPocqbKPVfuwalopEqJwXCsWCH623yKYTpU8d+doXpcKslBp8KY5cQf
   7ugMeOGadeFwrcedz1igrihyqjHpqW+Y4EphfHTwUs1RcDbwu+V7jtvb1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331903914"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331903914"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 19:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="915946649"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="915946649"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2023 19:49:59 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pSrl0-000B5h-01;
	Fri, 17 Feb 2023 03:49:58 +0000
Date: Fri, 17 Feb 2023 11:49:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.or,
	chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 1/2] erofs: convert hardcoded blocksize to sb->s_blocksize
Message-ID: <202302171143.RmhVCgqe-lkp@intel.com>
References: <20230216094745.47868-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216094745.47868-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jingbo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev next-20230216]
[cannot apply to xiang-erofs/fixes linus/master v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbo-Xu/erofs-set-block-size-to-the-on-disk-block-size/20230216-175045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20230216094745.47868-1-jefflexu%40linux.alibaba.com
patch subject: [PATCH 1/2] erofs: convert hardcoded blocksize to sb->s_blocksize
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230217/202302171143.RmhVCgqe-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/30b09ec3be57f3777d22e71d2d4e5ec70d9227f8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jingbo-Xu/erofs-set-block-size-to-the-on-disk-block-size/20230216-175045
        git checkout 30b09ec3be57f3777d22e71d2d4e5ec70d9227f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302171143.RmhVCgqe-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x234): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x254): additional relocation overflows omitted from the output
   mips-linux-ld: fs/erofs/data.o: in function `erofs_map_blocks_flatmode.constprop.0':
>> data.c:(.text.erofs_map_blocks_flatmode.constprop.0+0x118): undefined reference to `__divdi3'
   mips-linux-ld: fs/erofs/namei.o: in function `erofs_find_target_block.constprop.0':
>> namei.c:(.text.erofs_find_target_block.constprop.0+0xf8): undefined reference to `__divdi3'
   mips-linux-ld: fs/erofs/zmap.o: in function `compacted_load_cluster_from_disk':
>> zmap.c:(.text.compacted_load_cluster_from_disk+0x224): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
