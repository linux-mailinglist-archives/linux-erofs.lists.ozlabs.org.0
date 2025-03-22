Return-Path: <linux-erofs+bounces-117-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1256FA6CD4D
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Mar 2025 00:37:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKwhc5l4Zz2ygk;
	Sun, 23 Mar 2025 10:37:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742686640;
	cv=none; b=dVcoVZRjV9Y2TxglSUXDvAAuZ10E4UOqo3TzUReA8V8W8Lcp1OcXfpYVd9kXx3d6MJVSAly50pYhKrbL5AOQnHXF/D348D1nCPl0DCil24gIXhOonJK+W43xrOQvZSt0g6drpIab4Sh7fEL3wWesJguKTDLH9DgcKVosb+XGUTEPwLJ3T8V1vuvPcxahUvG3LZe9Fkmj6PVU9IffVnsLRb8kMR1ShhHGE6W+bf+OL6yoDQ68bHL0HRpMdX7Lv6ZijUqMHPiNUjwqBNcOgfVOcbpaX/MD4WnKArAKuzSsQ1RJsF0GTNFyXSZniXEv3Q2WB/kygQwxu8/DXHqutGlcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742686640; c=relaxed/relaxed;
	bh=RJyLqTt76DE2f1gCHP179gAf9drjXptTmeBN7wwXPQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXzTfPKkM9slzdX/wOsfCeuuEW2bD9c2qY0NNpqFoNIfDGQoaBDXKfxKPfYfFqwmRJHZRatj335qPGyv8oRriDPj8BV3udCCiTwaLIDeU4s+blygQ4zOr5Hvd+RezVLthkUAsFM7j4nb5yKcSFI/XHMUX0FjTKqpgCoyU5NipTJ+fm1iNIMV4AxVdJ6WFHcdLNtcEhL3Cj8p53rdyCdKGsM07fe02bSvmsYDIACVKvvmxDJq94vt6Oyj614tgC7IqQmj6/rgw9rmnDnpHyJnc3RqT1YdFvxk8cGWtLZHFCzLIf3ZQ9yimNt6kbQlNejijzj29P0wYRrwaSvLkx5XIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d+2k/GMz; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d+2k/GMz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKwhb4Jh1z2yfD
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 10:37:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742686640; x=1774222640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/fL38PohfZNzoYeO4e3wD60/qTiXOlKjNyMjNKu+IRc=;
  b=d+2k/GMz21belDr3CbeaAsj4Qg2a6NT+JHRKG/1WBHlN8e5+1hGuFYfP
   PZauu3mlM44Ovku1ofwOeyoBNImSqodIdZkPRnvEVy+/PJ433WQn6m4Tt
   dTJAyWg0nxZs/rH7R2HECmwghtgCCxjBzGMIPdN1c091NxK1ziAzb1oV/
   jNJxYUal2RfOLxVtfwwOBFUTcDrZYjQnJfarFQYQtyOsDhotxW+tS1tB4
   jQ72VaiXb1nV+qKEqbiTXL0ztLIXOKd7rjMzx6lpce4UUrmMJC3pf2fND
   0S8qX7BjzHdcGvNuKtQFZ882mRHbRuPSL0Gnp+oWAdd0063ZSSqUVujW4
   w==;
X-CSE-ConnectionGUID: sLB5TIC+SLGqlbFjkcLNJg==
X-CSE-MsgGUID: K7MvRaC+TKyXXiYPZbObqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="54553326"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="54553326"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 16:37:11 -0700
X-CSE-ConnectionGUID: Q4gcij9bRf6YlCYCu1aUrA==
X-CSE-MsgGUID: T10ovpUaTTKIen4JafwWaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="128530006"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Mar 2025 16:37:08 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw8On-0002SR-1u;
	Sat, 22 Mar 2025 23:37:05 +0000
Date: Sun, 23 Mar 2025 07:36:57 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Gao Xiang <xiang@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>
Subject: Re: [PATCH v2 8/9] fs: ext2, ext4: register an initrd fs detector
Message-ID: <202503230718.5DYAbNZO-lkp@intel.com>
References: <20250322-initrd-erofs-v2-8-d66ee4a2c756@cyberus-technology.de>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-initrd-erofs-v2-8-d66ee4a2c756@cyberus-technology.de>
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Stecklina-via-B4-Relay/initrd-remove-ASCII-spinner/20250323-043649
base:   88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
patch link:    https://lore.kernel.org/r/20250322-initrd-erofs-v2-8-d66ee4a2c756%40cyberus-technology.de
patch subject: [PATCH v2 8/9] fs: ext2, ext4: register an initrd fs detector
config: i386-buildonly-randconfig-001-20250323 (https://download.01.org/0day-ci/archive/20250323/202503230718.5DYAbNZO-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250323/202503230718.5DYAbNZO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503230718.5DYAbNZO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/ext2/initrd.c:27:33: error: too many arguments provided to function-like macro invocation
      27 | initrd_fs_detect(detect_ext2fs, BLOCK_SIZE);
         |                                 ^
   include/linux/initrd.h:63:9: note: macro 'initrd_fs_detect' defined here
      63 | #define initrd_fs_detect(detectfn)
         |         ^
>> fs/ext2/initrd.c:27:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
      27 | initrd_fs_detect(detect_ext2fs, BLOCK_SIZE);
         | ^
         | int
   2 errors generated.


vim +27 fs/ext2/initrd.c

    26	
  > 27	initrd_fs_detect(detect_ext2fs, BLOCK_SIZE);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

