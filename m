Return-Path: <linux-erofs+bounces-1309-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20F6C26AF9
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Oct 2025 20:16:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cyrM807hdz2xnh;
	Sat,  1 Nov 2025 06:16:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761938211;
	cv=none; b=VUR34+KFFZpC2nI3Kc/DkT6uwNu1CFDEJd/snUT560ypXSDEEJdykxVXkYSpOFTRLnPof98icXMkBWcQKHF1dvip33Om1wB+Emdjyk1sRVsjRKOhkZTS9HQxVBBsMmxcBmMKolhZMS/iweIYoN6yQYzH1fIs4JlUZrfTx6mHEbjtrRzq511JPRf8gmMJal7IIFF+gCdFc7Z3KdbBOEzi7gm32v97L8vqbtnFT7EWL6FdvcLyfTDOQl6kJea+OYZzrk9Gdmf4/vNuS2sRUH3Bp8/KE3YVgzp01sgfAvoxXXQrnI9VuxqoGxjkO/nPHvtpMfnlTzarzJ+1BknyJ1vAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761938211; c=relaxed/relaxed;
	bh=I2c9jF+bEQQSMju0DDWQPK6LVDBvQTxrgrkDpB/M8hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eq7UUlx9/bVNoToqmFVCuaGoCueGqU13s3LhgwWsDns65VRvCNJVeRqvMCf+xWcm7Cq/hErhyyGejJJVTxBFsnFGCGRLVyIuBn8MXiPIiRJd75A/QW+w3vfBYexZzY90+iSssfSLDVqucz3SbOZJppqOKWlYuYifOCbSh8SYFiwH2HZxdbZaVfI61Ev5DGvV2sbwNLXheoMTLW21SHnw20Qt/HBMvvXpp2KHSwhk2xcM+IGJRTtch8+n5NaoPnDu4M3OGIUkXl85BwNiSqzh70tj++VawHNKLYHn5zRuh9YsVyFQi0OiuYuGsDdCYIFjF4OdWkpiSwdvYwvC9+QRug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SeNixCOU; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SeNixCOU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cyrM51t80z2xdg
	for <linux-erofs@lists.ozlabs.org>; Sat,  1 Nov 2025 06:16:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761938209; x=1793474209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+9/UpViqJdn5LB/o1uEYW5FCLD3oDji5OcxpxzRAU+0=;
  b=SeNixCOUslXc3fvHhsvyZN69wziprKnfyar6iPBghaczia+eqYsWrink
   5tjr4aFFZ4n1eh3WSjVKbIO95rGF3F0qoGgUhiqnpQ4bOuE0qF1zWUdLT
   tiBaTnymrGpRhb2HUBXN9x+SX6KgCIoxM0qzce+WrloL9Yso3G8bP5Idv
   CN47icIdhrMTr40frAkmw3tmXoHPzCbS32de85W9zRY+1QneLQ5UlkQFZ
   sdNi78K1EbzXoWuuXlujx39iur55a13NKa++ptI12aOKZXG6F7whqNj8s
   xOdUFmbshaHb1yKHzvjrLGbIhP6I7wCxtdEpRaHUdg3X+oSQbCpHcECgX
   A==;
X-CSE-ConnectionGUID: bwfFTQ90QFKCTy8+kJ2iwA==
X-CSE-MsgGUID: 5NUHeGZuRxyodYIQRbVEUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="89569587"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="89569587"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:16:44 -0700
X-CSE-ConnectionGUID: Gp27Z5oaT06mygqL4SSVsA==
X-CSE-MsgGUID: syiqhr9ASsWESjVreTgwcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="217148119"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 31 Oct 2025 12:16:42 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEuc4-000NaO-2P;
	Fri, 31 Oct 2025 19:16:40 +0000
Date: Sat, 1 Nov 2025 03:16:28 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test 2/2] ld.lld: error: relocation R_PPC_ADDR16_HI
 cannot be used against local symbol; recompile with -fPIC
Message-ID: <202511010331.SSF687V8-lkp@intel.com>
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
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   3bf692888f2707392872a69cd125c800778e72e2
commit: 3bf692888f2707392872a69cd125c800778e72e2 [2/2] erofs: avoid infinite loop due to incomplete zstd-compressed data
config: powerpc-randconfig-002-20251101 (https://download.01.org/0day-ci/archive/20251101/202511010331.SSF687V8-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511010331.SSF687V8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511010331.SSF687V8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against local symbol; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/kernel/head_85xx.o)
   >>> referenced by head_85xx.S:186 (arch/powerpc/kernel/head_85xx.S:186)
   >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x3ea) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

