Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCF6DDFF0
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 17:50:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pwr0B2YSVz3c79
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 01:50:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fSVY4guD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fSVY4guD;
	dkim-atps=neutral
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pwr014C21z3bf7
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Apr 2023 01:50:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681228225; x=1712764225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/xR4Z2+vj/MHKnsKv8/M5WTZq4akLnY/oPBIaizEMxQ=;
  b=fSVY4guDFs5MjRZFQguC9tBJGBSo+OKk755I6YaPt3aL+Owmrd73A9kq
   u6SvcgxVo/bOY3UZbgpKJyfEV8qT5I/eEjTGfoJVf8TZiVO6OLMVunNl6
   ydJt4x6qn/+d3+opDrSlRtShxn8ciIJ5UcVEJ6KWjgI1HlzO0OB1zEGkO
   zxNUExB9SY7amgV8ndRPt59LXBz08MNdrQiTIps7B8QJIP7n+q7eHUHNj
   AI6zLGkw9pjpaiwlzPq/3YDh4i85dOo9mBIbJILmEFnS+hKWk+puuCPy6
   fU05wjtrHeiydrFNyWjNtiLgvFSyqreM3drgBW+j1NZwf2xzvNBlJT8bS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341144256"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341144256"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 08:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="777966844"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="777966844"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2023 08:50:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pmGG7-000WRn-0i;
	Tue, 11 Apr 2023 15:50:15 +0000
Date: Tue, 11 Apr 2023 23:49:29 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test 17/17] ld.lld: error: undefined symbol:
 z_erofs_aops
Message-ID: <202304112351.TOHeKtRR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: llvm@lists.linux.dev, linux-erofs@lists.ozlabs.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   64be79d41fc0aefc57b4127f949e9995e739398e
commit: 64be79d41fc0aefc57b4127f949e9995e739398e [17/17] erofs: get rid of z_erofs_fill_inode()
config: hexagon-randconfig-r041-20230409 (https://download.01.org/0day-ci/archive/20230411/202304112351.TOHeKtRR-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/commit/?id=64be79d41fc0aefc57b4127f949e9995e739398e
        git remote add xiang-erofs https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
        git fetch --no-tags xiang-erofs dev-test
        git checkout 64be79d41fc0aefc57b4127f949e9995e739398e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304112351.TOHeKtRR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: z_erofs_aops
   >>> referenced by inode.c
   >>>               fs/erofs/inode.o:(erofs_iget) in archive vmlinux.a
   >>> referenced by inode.c
   >>>               fs/erofs/inode.o:(erofs_iget) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
