Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1663CCA1
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 01:50:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMLGW3MNXz3bWC
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 11:50:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F894fpX8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F894fpX8;
	dkim-atps=neutral
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMLGL0bxWz30RG
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 11:50:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669769418; x=1701305418;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=d8zzYwiMyTL70cZGKrMD2kR/bZEwrQdfnrKTy19dt8A=;
  b=F894fpX8AQT+vIW2UsH84vZbtoY0/heZtNCnDyhFo47nYp3QVrVR1QQY
   82wqPFPnpw2zbRA6AvyGelu96zIr7B91Daj/ADd3d1CHQTu6kNaiNQUSz
   eDCb2QxWDl4x9a7dHCAG0+v5+YmYeSIXafBMezdTp8sVrQBRAVGICyphE
   4J4ijzPBjuENLvcSlTnM9I9ZCSZJolsRKQ1gEn5mmoCxqyCfh+tG8KCqO
   WCv0/Q0Sz4qUUrHPpGKwa+TmMq3J7p3R5MjpBf28q0t+ZYxZuWaMi5wO5
   xGVtZqklW6O4CcJUlrqD+k+Pmx4ZjDuPxZGoB4xkdmm40c8HX/yNtsGUm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="312885022"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="312885022"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 16:50:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="972901191"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="972901191"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2022 16:50:08 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p0BId-0009EA-2W;
	Wed, 30 Nov 2022 00:50:07 +0000
Date: Wed, 30 Nov 2022 08:49:14 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 0717326aca9fd4f5441cee677e1b8a03760381e2
Message-ID: <6386a88a.AUw45HKia7NSiNPK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 0717326aca9fd4f5441cee677e1b8a03760381e2  erofs: switch to prepare_ondemand_read() in fscache mode

elapsed time: 1730m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
i386                              allnoconfig
arc                               allnoconfig
arm                               allnoconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
sh                               allmodconfig
arc                  randconfig-r043-20221128
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                 randconfig-a002-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a001-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a004-20221128
i386                 randconfig-a006-20221128
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
x86_64               randconfig-a001-20221128
x86_64               randconfig-a003-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a002-20221128
x86_64               randconfig-a006-20221128
x86_64               randconfig-a005-20221128
i386                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r041-20221128
s390                 randconfig-r044-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
x86_64               randconfig-a014-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a015-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a014-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
