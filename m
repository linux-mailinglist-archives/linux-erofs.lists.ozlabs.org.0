Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2405B6DE0AB
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 18:12:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PwrTC1MmDz3bjY
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 02:12:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JCBZ6yP3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JCBZ6yP3;
	dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PwrT33VvDz3bg3
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Apr 2023 02:12:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681229527; x=1712765527;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yEiqQNs/vmI3Sygxu5HasRX8D6La1NiQ9OSNHH56wDQ=;
  b=JCBZ6yP3u56QXW/Gw96bdP5hPY5yDAkXJv7z/mVfJ00DT0Z0QVtpVE7G
   AOB+CficZb8bdboLcaeCSigdthbFw25DzkcaV8R82Z9ug7WRsZCHdWNlq
   S3iEZBOYr+38jczqRDRVbMETe+HgxTJqAwj/xepIDMUbHoGJjvW2qvNOn
   mp+DyrlKWufoGAIJPI5J9nx//FI+yqn7QNOiy8zxlMT0iBC+FqY20Adwi
   /M+cUrREk0hnGpfkwJT4wUVLcRkt8PU40cO4ElnAct0pZNN/T/kiUN5jK
   UXN1QGovWpIY2LviKYkNq3Lwr/rg4gtlzq1a7g+Qq6pXg/HveYljbbSlK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343669295"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343669295"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="691210000"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="691210000"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2023 09:10:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pmGZT-000WST-26;
	Tue, 11 Apr 2023 16:10:15 +0000
Date: Wed, 12 Apr 2023 00:10:04 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test 17/17] inode.c:undefined reference to
 `z_erofs_aops'
Message-ID: <202304120041.dKiP6YdV-lkp@intel.com>
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
Cc: linux-erofs@lists.ozlabs.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   64be79d41fc0aefc57b4127f949e9995e739398e
commit: 64be79d41fc0aefc57b4127f949e9995e739398e [17/17] erofs: get rid of z_erofs_fill_inode()
config: m68k-randconfig-r021-20230410 (https://download.01.org/0day-ci/archive/20230412/202304120041.dKiP6YdV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/commit/?id=64be79d41fc0aefc57b4127f949e9995e739398e
        git remote add xiang-erofs https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
        git fetch --no-tags xiang-erofs dev-test
        git checkout 64be79d41fc0aefc57b4127f949e9995e739398e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120041.dKiP6YdV-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: fs/erofs/inode.o: in function `erofs_fill_inode':
>> inode.c:(.text+0x9be): undefined reference to `z_erofs_aops'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
