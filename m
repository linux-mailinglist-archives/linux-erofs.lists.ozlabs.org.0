Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9847F85C
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Dec 2021 18:17:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMSCX4dV1z2yp5
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 04:17:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cZqNAhBi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cZqNAhBi; dkim-atps=neutral
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMSCP3wFrz2x9Z
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 04:17:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640539025; x=1672075025;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=J3Q0RCvoEnNPwuJZs42oa8Mj5L564sxmIpuMKVtuOHY=;
 b=cZqNAhBiEw+xwsLDrkbu7o0CFrk4mrAw69g4OEZnlWMMBJiAaHgjiSZt
 KjAnnMiXLtOac7J8uMZJTIQFKRIrW3ObQ2ny9VyxxM2yujrgcmBzN8miu
 3t4NN8KW7CgU6cBQMI6eZsFZfCv6MqOgJIilAUFsK2LQS7YiPmcvMo2zJ
 s4YbxzFNbyCuhXL3deTxYHTh991tKYsJHrTqJNuhzOQdU9nPBvRsnoMCZ
 rzXNYJGu6357iWaf4L+adJTA0z5h+T7ZNsK0jo9Nz9LRPGB2YBygGqBHw
 aaypG9OKpWBbUvSkUdGvaMJglPMboV+LHSBmwc6D9ZvUlA2KgbpYU4mKZ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="228426116"
X-IronPort-AV: E=Sophos;i="5.88,237,1635231600"; d="scan'208";a="228426116"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2021 09:15:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,237,1635231600"; d="scan'208";a="686076494"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 26 Dec 2021 09:15:55 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n1X7i-0005ak-AB; Sun, 26 Dec 2021 17:15:54 +0000
Date: Mon, 27 Dec 2021 01:14:59 +0800
From: kernel test robot <lkp@intel.com>
To: Yue Hu <huyue2@yulong.com>
Subject: [xiang-erofs:dev-test 10/10] ERROR: modpost: "__umoddi3"
 [fs/erofs/erofs.ko] undefined!
Message-ID: <202112270112.rgS0dZPa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-erofs@lists.ozlabs.org, kbuild-all@lists.01.org,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   9204beaeb1c1bf4eeac42df048c5bd829deedfff
commit: 9204beaeb1c1bf4eeac42df048c5bd829deedfff [10/10] erofs: add on-disk compressed tail-packing inline support
config: m68k-mvme16x_defconfig (https://download.01.org/0day-ci/archive/20211227/202112270112.rgS0dZPa-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/commit/?id=9204beaeb1c1bf4eeac42df048c5bd829deedfff
        git remote add xiang-erofs https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
        git fetch --no-tags xiang-erofs dev-test
        git checkout 9204beaeb1c1bf4eeac42df048c5bd829deedfff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [fs/erofs/erofs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
