Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8139EFF68
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 23:32:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8RzQ55Nbz30h8
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 09:32:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734042720;
	cv=none; b=bQIenDgoweI/OA12A6mQzJYPBu0xIJJE3FM18E8eoOw7WpolSMMgppevJD5nsLgvuAq8X3DsLiTueGBwyZ5l9OtvSJmYxMr+YqUFyI2wHC3GArwCyIrIimwMq/mCHrtapSSY7SUjO6wADLgG3gk2evdjtBXftEiOCIPDSowC5r/Gv4HG7n/UcAA6w7vrrzq5hinDWTA/sNFU5TIyPMfGPB/fehJE0m8D/GoIB7QhHg8YcnyxwifrlrWpzLmMLCjweaiuPtGEneSTT43RcB2YgbZ8YVw7tD54SP7dotTfNQTQ3jT8q9gUPV8Jh5ZfFBrq85E5vUDhjlxqO9FBa8S87w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734042720; c=relaxed/relaxed;
	bh=wtjeRMdMr+eNCx890D+XdzqJ85PYkrLSgXYXGdXIuV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oqXGQ5E2Ne54GKzwCoUNuD+dmDYhPzujjuL3g0CVpbCwnoYwtksofYf6Q4DRqfpWIX/UxaSDMAv+hZA4G9Hafw+lsZwV3HOTl6HDxKjrw8fIIZO5WW5ZauJS1R2w9Oe5ZbWjN/YF586dYbtyyYcQ+fmKIWKN+0rPv1Tc3yGgB8QMEC7CFmwBzDWbHd5Chkcp1i/foWXOWkfe7DJtdD+tc5PLbyib/08POmG00smsE5UY43NMfONOkMp+0uwdb0j2wOLxmfXGYsytjFWX9bGIb7EKHSeOLr90t1c7hM4ga+95bmIdyd4oOTVTl6JNXxt4T8b9FSB8uUzQ3ewY4eomAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kW62Oob6; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kW62Oob6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8RzL1Zrbz2yF0
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 09:31:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734042718; x=1765578718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Iyry7ybOHW7OB9mFHzNYHKQSCwJXgEzQCGV9ZSe/TM=;
  b=kW62Oob6dxkLq/nA9K/glF0iVXwMrI7660Sm4U89EV89ZlPSAFYPGQL+
   TGyQgUy7G3FKKlqMz/VC87C+DW42b6VGDLC3EY7w9eYti69k3vumSEJNS
   PEVeHp2KQ8BGvHoZ3eRp/LWpM5WlBOjaqcb43Tb4wznqgUKLOyFpz8c80
   H12Ukb9kM7gh7SWRMvTdPX/77v/1bxFamMS1c8Wr7M4LF8tDNF/qLtdgv
   fvmX+wNrYR+M/6hq4nsv/rV7s0DLEgkbVYWiJDk0EU1lEqL2GKhXL00k0
   PIQo1yh9lPh2Ihny081dMGEgQVwHEurz0fY6U2YdwKc9jfGh+eDACN+0K
   g==;
X-CSE-ConnectionGUID: U71/vEiRQcercSKsPDF6Sg==
X-CSE-MsgGUID: dWYw6toDTW+Kh6SY8I7t4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38419128"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38419128"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 14:31:52 -0800
X-CSE-ConnectionGUID: 09SM+PfXSXKjBjVRmksCKw==
X-CSE-MsgGUID: wBJEsb5QTpe3C4i0kwe8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101452743"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Dec 2024 14:31:50 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLrim-000BRU-0o;
	Thu, 12 Dec 2024 22:31:48 +0000
Date: Fri, 13 Dec 2024 06:30:51 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:fixes 6/7] fs/erofs/fscache.c:201:30: error: 'struct
 erofs_map_dev' has no member named 'm_fscache'
Message-ID: <202412130644.hPflG7Qg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
head:   320077e635e75d3053b81adb7c0d53f0a89e300d
commit: 34cff83201d5d796f808bf72ab734c4aae425bff [6/7] erofs: reference `struct erofs_device_info` for erofs_map_dev
config: sparc64-randconfig-001-20241213 (https://download.01.org/0day-ci/archive/20241213/202412130644.hPflG7Qg-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241213/202412130644.hPflG7Qg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412130644.hPflG7Qg-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/erofs/fscache.c: In function 'erofs_fscache_bio_alloc':
>> fs/erofs/fscache.c:201:30: error: 'struct erofs_map_dev' has no member named 'm_fscache'
     201 |         io->io.private = mdev->m_fscache->cookie;
         |                              ^~
   fs/erofs/fscache.c: In function 'erofs_fscache_data_read_slice':
   fs/erofs/fscache.c:319:47: error: 'struct erofs_map_dev' has no member named 'm_fscache'
     319 |         ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie,
         |                                               ^


vim +201 fs/erofs/fscache.c

a1bafc3109d713e Jingbo Xu 2024-03-08  194  
a1bafc3109d713e Jingbo Xu 2024-03-08  195  struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
a1bafc3109d713e Jingbo Xu 2024-03-08  196  {
a1bafc3109d713e Jingbo Xu 2024-03-08  197  	struct erofs_fscache_bio *io;
a1bafc3109d713e Jingbo Xu 2024-03-08  198  
a1bafc3109d713e Jingbo Xu 2024-03-08  199  	io = kmalloc(sizeof(*io), GFP_KERNEL | __GFP_NOFAIL);
a1bafc3109d713e Jingbo Xu 2024-03-08  200  	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
a1bafc3109d713e Jingbo Xu 2024-03-08 @201  	io->io.private = mdev->m_fscache->cookie;
a1bafc3109d713e Jingbo Xu 2024-03-08  202  	io->io.end_io = erofs_fscache_bio_endio;
a1bafc3109d713e Jingbo Xu 2024-03-08  203  	refcount_set(&io->io.ref, 1);
a1bafc3109d713e Jingbo Xu 2024-03-08  204  	return &io->bio;
a1bafc3109d713e Jingbo Xu 2024-03-08  205  }
a1bafc3109d713e Jingbo Xu 2024-03-08  206  

:::::: The code at line 201 was first introduced by commit
:::::: a1bafc3109d713ed83f73d61ba5cb1e6fd80fdbc erofs: support compressed inodes over fscache

:::::: TO: Jingbo Xu <jefflexu@linux.alibaba.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
