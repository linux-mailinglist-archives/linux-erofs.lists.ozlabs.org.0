Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921786DDF09
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 17:10:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pwq5965dQz3c9L
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 01:09:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kesg6Lf7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kesg6Lf7;
	dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pwq531bqCz2x9L
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Apr 2023 01:09:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681225783; x=1712761783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3OfE8LZYaidiRnsR47FVeG9AtUrWZHKX8WBBuHra3QI=;
  b=kesg6Lf7v3IP6+AL9YnFugcd36rAd/QDKU14r3mAeUTFE+z6ivKaMBKy
   q0xTfwVpfJ9f92RQgMV5enrw8ZrASGgqf10eJx7Ph7zL031Z0TSHo8oGI
   sPhjYdHSdxCvGBIdKPoZm1kq6CrHsp5vponPNG4qpb7zuZExzMfkyJ2VI
   qbswym5UCw030EU7hr9r1RAL1B/13I1ZQKJhbm2I+5xE9GpGCcB2DUDHN
   e6RNv2AkrQMGsmXGD8DA1yEKHPwvG1d8sh9RH/DHWRAx/4B92uzFddo3A
   ZPHXLd+4RUFpiUkR6YvyCWUbzjlMYHn8ynKuqbPFxXtdm+BI+RMinU2Fr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="323275925"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="323275925"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 08:09:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="718990083"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="718990083"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Apr 2023 08:09:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pmFcQ-000WQ5-0T;
	Tue, 11 Apr 2023 15:09:14 +0000
Date: Tue, 11 Apr 2023 23:08:18 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test 17/17] fs/erofs/inode.c:296: undefined
 reference to `z_erofs_aops'
Message-ID: <202304112232.IFr8fsS7-lkp@intel.com>
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
config: powerpc-randconfig-r022-20230410 (https://download.01.org/0day-ci/archive/20230411/202304112232.IFr8fsS7-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/commit/?id=64be79d41fc0aefc57b4127f949e9995e739398e
        git remote add xiang-erofs https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
        git fetch --no-tags xiang-erofs dev-test
        git checkout 64be79d41fc0aefc57b4127f949e9995e739398e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304112232.IFr8fsS7-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: fs/erofs/inode.o: in function `erofs_fill_inode':
>> fs/erofs/inode.c:296: undefined reference to `z_erofs_aops'
>> powerpc-linux-ld: fs/erofs/inode.c:296: undefined reference to `z_erofs_aops'


vim +296 fs/erofs/inode.c

   245	
   246	static int erofs_fill_inode(struct inode *inode)
   247	{
   248		struct erofs_inode *vi = EROFS_I(inode);
   249		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
   250		void *kaddr;
   251		unsigned int ofs;
   252		int err = 0;
   253	
   254		trace_erofs_fill_inode(inode);
   255	
   256		/* read inode base data from disk */
   257		kaddr = erofs_read_inode(&buf, inode, &ofs);
   258		if (IS_ERR(kaddr))
   259			return PTR_ERR(kaddr);
   260	
   261		/* setup the new inode */
   262		switch (inode->i_mode & S_IFMT) {
   263		case S_IFREG:
   264			inode->i_op = &erofs_generic_iops;
   265			if (erofs_inode_is_data_compressed(vi->datalayout))
   266				inode->i_fop = &generic_ro_fops;
   267			else
   268				inode->i_fop = &erofs_file_fops;
   269			break;
   270		case S_IFDIR:
   271			inode->i_op = &erofs_dir_iops;
   272			inode->i_fop = &erofs_dir_fops;
   273			inode_nohighmem(inode);
   274			break;
   275		case S_IFLNK:
   276			err = erofs_fill_symlink(inode, kaddr, ofs);
   277			if (err)
   278				goto out_unlock;
   279			inode_nohighmem(inode);
   280			break;
   281		case S_IFCHR:
   282		case S_IFBLK:
   283		case S_IFIFO:
   284		case S_IFSOCK:
   285			inode->i_op = &erofs_generic_iops;
   286			init_special_inode(inode, inode->i_mode, inode->i_rdev);
   287			goto out_unlock;
   288		default:
   289			err = -EFSCORRUPTED;
   290			goto out_unlock;
   291		}
   292	
   293		if (erofs_inode_is_data_compressed(vi->datalayout)) {
   294			if (!erofs_is_fscache_mode(inode->i_sb) &&
   295			    inode->i_sb->s_blocksize_bits == PAGE_SHIFT) {
 > 296				inode->i_mapping->a_ops = &z_erofs_aops;
   297				err = 0;
   298			} else {
   299				err = -EOPNOTSUPP;
   300			}
   301			goto out_unlock;
   302		}
   303		inode->i_mapping->a_ops = &erofs_raw_access_aops;
   304		mapping_set_large_folios(inode->i_mapping);
   305	#ifdef CONFIG_EROFS_FS_ONDEMAND
   306		if (erofs_is_fscache_mode(inode->i_sb))
   307			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
   308	#endif
   309	
   310	out_unlock:
   311		erofs_put_metabuf(&buf);
   312		return err;
   313	}
   314	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
