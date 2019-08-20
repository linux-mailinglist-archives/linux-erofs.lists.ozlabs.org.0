Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1081F957A0
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 08:47:21 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CLv94JQQzDqd1
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 16:47:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=philip.li@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CLtW3Dc0zDqdD
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2019 16:46:37 +1000 (AEST)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Aug 2019 23:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,407,1559545200"; d="scan'208";a="172359689"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
 by orsmga008.jf.intel.com with ESMTP; 19 Aug 2019 23:46:32 -0700
Date: Tue, 20 Aug 2019 14:50:38 +0800
From: Philip Li <philip.li@intel.com>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH] staging: erofs: fix an error handling in erofs_readdir()
Message-ID: <20190820065038.GG4479@intel.com>
References: <20190818031855.9723-1-hsiangkao@aol.com>
 <201908182116.RRufKUpl%lkp@intel.com>
 <20190818132503.GA26232@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818132503.GA26232@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, kbuild test robot <lkp@intel.com>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, kbuild-all@01.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 18, 2019 at 09:25:04PM +0800, Gao Xiang wrote:
> On Sun, Aug 18, 2019 at 09:17:52PM +0800, kbuild test robot wrote:
> > Hi Gao,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on linus/master]
> > [cannot apply to v5.3-rc4 next-20190816]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> ... those patches should be applied to staging tree
> since linux-next has not been updated yet...
thanks for the feedback, we will consider this to our todo list.

> 
> Thanks,
> Gao Xiang
> 
> > 
> > url:    https://github.com/0day-ci/linux/commits/Gao-Xiang/staging-erofs-fix-an-error-handling-in-erofs_readdir/20190818-191344
> > config: arm64-allyesconfig (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=arm64 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/staging/erofs/dir.c: In function 'erofs_readdir':
> > >> drivers/staging/erofs/dir.c:110:11: error: 'EFSCORRUPTED' undeclared (first use in this function); did you mean 'FS_NRSUPER'?
> >        err = -EFSCORRUPTED;
> >               ^~~~~~~~~~~~
> >               FS_NRSUPER
> >    drivers/staging/erofs/dir.c:110:11: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > vim +110 drivers/staging/erofs/dir.c
> > 
> >     85	
> >     86	static int erofs_readdir(struct file *f, struct dir_context *ctx)
> >     87	{
> >     88		struct inode *dir = file_inode(f);
> >     89		struct address_space *mapping = dir->i_mapping;
> >     90		const size_t dirsize = i_size_read(dir);
> >     91		unsigned int i = ctx->pos / EROFS_BLKSIZ;
> >     92		unsigned int ofs = ctx->pos % EROFS_BLKSIZ;
> >     93		int err = 0;
> >     94		bool initial = true;
> >     95	
> >     96		while (ctx->pos < dirsize) {
> >     97			struct page *dentry_page;
> >     98			struct erofs_dirent *de;
> >     99			unsigned int nameoff, maxsize;
> >    100	
> >    101			dentry_page = read_mapping_page(mapping, i, NULL);
> >    102			if (dentry_page == ERR_PTR(-ENOMEM)) {
> >    103				errln("no memory to readdir of logical block %u of nid %llu",
> >    104				      i, EROFS_V(dir)->nid);
> >    105				err = -ENOMEM;
> >    106				break;
> >    107			} else if (IS_ERR(dentry_page)) {
> >    108				errln("fail to readdir of logical block %u of nid %llu",
> >    109				      i, EROFS_V(dir)->nid);
> >  > 110				err = -EFSCORRUPTED;
> >    111				break;
> >    112			}
> >    113	
> >    114			de = (struct erofs_dirent *)kmap(dentry_page);
> >    115	
> >    116			nameoff = le16_to_cpu(de->nameoff);
> >    117	
> >    118			if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
> >    119				     nameoff >= PAGE_SIZE)) {
> >    120				errln("%s, invalid de[0].nameoff %u",
> >    121				      __func__, nameoff);
> >    122	
> >    123				err = -EIO;
> >    124				goto skip_this;
> >    125			}
> >    126	
> >    127			maxsize = min_t(unsigned int,
> >    128					dirsize - ctx->pos + ofs, PAGE_SIZE);
> >    129	
> >    130			/* search dirents at the arbitrary position */
> >    131			if (unlikely(initial)) {
> >    132				initial = false;
> >    133	
> >    134				ofs = roundup(ofs, sizeof(struct erofs_dirent));
> >    135				if (unlikely(ofs >= nameoff))
> >    136					goto skip_this;
> >    137			}
> >    138	
> >    139			err = erofs_fill_dentries(ctx, de, &ofs, nameoff, maxsize);
> >    140	skip_this:
> >    141			kunmap(dentry_page);
> >    142	
> >    143			put_page(dentry_page);
> >    144	
> >    145			ctx->pos = blknr_to_addr(i) + ofs;
> >    146	
> >    147			if (unlikely(err))
> >    148				break;
> >    149			++i;
> >    150			ofs = 0;
> >    151		}
> >    152		return err < 0 ? err : 0;
> >    153	}
> >    154	
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
