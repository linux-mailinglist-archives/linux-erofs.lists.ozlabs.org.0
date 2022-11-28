Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BF832639F75
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Nov 2022 03:34:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NL8g74rpDz3c1n
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Nov 2022 13:34:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gY+RnSND;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gY+RnSND;
	dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NL8g2433hz2xH8
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Nov 2022 13:34:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669602846; x=1701138846;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IBxqZuJINkaKEwpYTNIoYsTtTouyXQQw4XRoTFlDn80=;
  b=gY+RnSNDy4nSc4T3BjuKJQbuvmTGHpWGj/isZxBE32YG1eZA6r9IQ5nr
   mAeJe0smFXOpRQbfupSttRTi12Vo93CS0Te3CPVdXmz0/x4U3D/tX+JB4
   Sfm6DaMLg5P1pucVnOXcca/VyS7Pw1gDSxXQTyj3jrpGgI1iSsw42rek+
   OOyLo24B8yefu4ACRAGXfC8L5EIcclCFqKShTELnigkD+uSFl2NLOidXQ
   zC4M05ZTBeNQLbyrsBxNwRKNB2Tnd5S5fWlTw67js2u3ZitUtFNjjJf0E
   OYcurUP/R277Vx40DySMq1BWNDHFghvJNR7qFOJj1UtQh2I1MtwMBfiaU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="294433651"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="294433651"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 18:34:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749199797"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="749199797"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Nov 2022 18:34:01 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ozTy4-0007bD-23;
	Mon, 28 Nov 2022 02:34:00 +0000
Date: Mon, 28 Nov 2022 10:33:16 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 313e9413d512ff6b0814da2a989f01872224c87a
Message-ID: <63841dec.slWkQZASG4hXI1y9%lkp@intel.com>
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
branch HEAD: 313e9413d512ff6b0814da2a989f01872224c87a  erofs: switch to prepare_ondemand_read() in fscache mode

elapsed time: 752m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
arc                  randconfig-r043-20221127
x86_64                        randconfig-a006
riscv                randconfig-r042-20221127
i386                          randconfig-a003
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
s390                                defconfig
x86_64                        randconfig-a013
arc                               allnoconfig
i386                          randconfig-a005
x86_64                        randconfig-a011
s390                 randconfig-r044-20221127
x86_64                        randconfig-a004
i386                          randconfig-a016
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
i386                                defconfig
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a012
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
ia64                             allmodconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221127
hexagon              randconfig-r041-20221127
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
