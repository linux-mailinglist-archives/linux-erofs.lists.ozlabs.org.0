Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D437916CC
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 15:25:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BHqd3j7fzDrJY
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 23:25:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566134733;
	bh=jXAwSynhU6+kPJcDbc4BRjglp0ya2h2NUScelrrEqXw=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=D/lNw8+DpDuKw/AEYpG7SI7DO17Epvq8fp1ariEtdQQYR8mPEqfLZporKoOsqnzJ8
	 s2+QaYAhOEyQD2RiNUzgddHeLlwe1PRAU3fSuyrXE6Gv6SEvN1a7tMDQN24vyLRlR3
	 o2X4ct5nuHg1G9QrzcJCep6w2Jb7CQW4tx79dnH71fpIR7OaAZLb0kXkeF4Yum3BA9
	 rCKiIo4OJoSOzlL5cCLORdD1gXsAMIWQQud/6hP2rj4O2JiogZNmA98kOGbVzT6uQl
	 4mlznLli3NFSgCMI3H+iyRrRxf2ciNAvGldT2VjhQHj7ONDo5UleuWKo2M8t5q4M8K
	 c7duiIb87L8xQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.145; helo=sonic308-17.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="RPAfhOnM"; 
 dkim-atps=neutral
Received: from sonic308-17.consmr.mail.ir2.yahoo.com
 (sonic308-17.consmr.mail.ir2.yahoo.com [77.238.178.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BHqV441yzDrB3
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 23:25:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566134720; bh=J5OwcfzuoKmPwwNV5kjnNoJZXy9tFxt/Nkggpag2DlE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=RPAfhOnMQOqsuP04WBkKMmTmOwo2IrPHNcNRfP4yT3ZBJrbZQLjtb5IRVMxe7PkZ/AU6Mr8FXL+12Xul8dkx88xo5PuhajlVycj4wVAOAdsGHCfVekycEE7EenqHrJ31kFWRpDwEgUKoeyYu97Nuc2cBQJOcjDfddXYS1UF/sBxoi7JrmuaFTm6x/oOeQsdngukEMgkA3wxp+/gAgTh4okdej4TgBosfLFdpXYoDsBMtO1nXvSK5UkLYZD/hx9jw67ERGkJvysT0xgUm9Xf7gUosLrrnreLzjZ3/9JmcwL3ZahBYaHPNeLNUG8s8QVDHCbI08wu5OP8WsoH+82aPYg==
X-YMail-OSG: rySOCGEVM1kKFbE28jMNYVWHuCRZtiGYiizlje5jWJHu1dTwExbD.W.2fL9daG8
 IPw6AtJCT9626396HlpSFWG1S0B3iHjwBWXG0fnXzBdxRBVNBrGFziyXnLozdEfG.VGLcm_2oZm4
 9EU8EEbQWRp.e9I_a1O3leTz.uQNBBr9UTsmdEZOXeiMnM2raR873pmDhYjo6bVJTZP5O6FRyD8T
 fXboKzUy4FdRLBOpj91sm_2hmuWCQQk9X8u1qKJXwXka.HvIAC2_gdRfheBxDrcSowMjhiPEU9tu
 AKRcNxXK93j6yX6aUn8srXiHcjk_jQZLkP3phZ8mqGztMAt10iQPdmVAODEauQaAu955nHN0APJv
 golkFqa3NUbrJew70LqR6YYlpjh4.cWcQMZ16UbcKXQICBocvllisG7WFy8tURJjJtQ.C_ZQmEab
 6eJJ8Yoe_WTX5BX2lGGghqIZESxP_Ygn4BgOCMAlaaPR30ezKbpp2T6pK0pLxzy_xRd6w_6PBpUq
 yhj4l2bI3xmZZ5VIcs83HtLr7Ubna5y_mDMH8.ymYM9Nsk8dwjjPzywfYiYBshBiXurn82qB0w0X
 xX2NLD.34IHBGxqEK4Q24Kev8yeEIjF2mDizgE8Yn2ALCZS4i5jUC8Q2bm1DPloAg6ssIe3Sufh_
 1LB4IsP_HlYh5vkVDKmWNG_MxB3fZPueIsMTRIj43znUzwrRrf.tdvdvbOz1k7hoBVBKgeGelSi.
 vydUON8U006dsQOknM2INymlYLZAtciDRXWMWFAbwYA7AoIabrEt60.zDmE2.kburnH2qFrBXGOd
 0cWZY0vlfPxL2wNyGC39ehA.tRHq1yx3Ui3o9ljGVAHDG6j21uko0tn4nbJLU7OdFXJxkKOEWDH0
 K59QwybuSVEcyAE1JyIjyeDrFCd3ajPSVi9IirahdtoZ5kqhiJ0kcqUGDCH.AmqLiPzPTXk5vG5u
 y_sYB4xR00EOts3otk70a9nL9NfZXzew0ISNWLK8S9U0jRxaDqH5deyC8NhCJ9cavDn66BuKSm0F
 U5kEG2CpxEgBfFJLldCs2TWMSftCissJScOLF7jvGxefwGpZTHfTMrpzIto9ZoFzzw7SQrW8kZV6
 WDvx0PFHwY7G58A8KsMCwNWd9xYGNmwmUCrMMbUNl4MVKCwJ69cK06y_4Q00EBRXOepENs5l0ZlN
 3dv0hsoMzi9dTwpBMdizuTd5QLv5jKGVZgKl9vzGUFVf7kuApl29.GEcg1G385AiYiIAmC8rSjQ3
 4Zik7hU6MSjGTX12wiB9Wv57qoz8Yg6pHlqEB
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 18 Aug 2019 13:25:20 +0000
Received: by smtp412.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID f2d2ae84838ecf7bc6a5d59b227cc76f; 
 Sun, 18 Aug 2019 13:25:16 +0000 (UTC)
Date: Sun, 18 Aug 2019 21:25:04 +0800
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] staging: erofs: fix an error handling in erofs_readdir()
Message-ID: <20190818132503.GA26232@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190818031855.9723-1-hsiangkao@aol.com>
 <201908182116.RRufKUpl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908182116.RRufKUpl%lkp@intel.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, kbuild-all@01.org,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 18, 2019 at 09:17:52PM +0800, kbuild test robot wrote:
> Hi Gao,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc4 next-20190816]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

... those patches should be applied to staging tree
since linux-next has not been updated yet...

Thanks,
Gao Xiang

> 
> url:    https://github.com/0day-ci/linux/commits/Gao-Xiang/staging-erofs-fix-an-error-handling-in-erofs_readdir/20190818-191344
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/staging/erofs/dir.c: In function 'erofs_readdir':
> >> drivers/staging/erofs/dir.c:110:11: error: 'EFSCORRUPTED' undeclared (first use in this function); did you mean 'FS_NRSUPER'?
>        err = -EFSCORRUPTED;
>               ^~~~~~~~~~~~
>               FS_NRSUPER
>    drivers/staging/erofs/dir.c:110:11: note: each undeclared identifier is reported only once for each function it appears in
> 
> vim +110 drivers/staging/erofs/dir.c
> 
>     85	
>     86	static int erofs_readdir(struct file *f, struct dir_context *ctx)
>     87	{
>     88		struct inode *dir = file_inode(f);
>     89		struct address_space *mapping = dir->i_mapping;
>     90		const size_t dirsize = i_size_read(dir);
>     91		unsigned int i = ctx->pos / EROFS_BLKSIZ;
>     92		unsigned int ofs = ctx->pos % EROFS_BLKSIZ;
>     93		int err = 0;
>     94		bool initial = true;
>     95	
>     96		while (ctx->pos < dirsize) {
>     97			struct page *dentry_page;
>     98			struct erofs_dirent *de;
>     99			unsigned int nameoff, maxsize;
>    100	
>    101			dentry_page = read_mapping_page(mapping, i, NULL);
>    102			if (dentry_page == ERR_PTR(-ENOMEM)) {
>    103				errln("no memory to readdir of logical block %u of nid %llu",
>    104				      i, EROFS_V(dir)->nid);
>    105				err = -ENOMEM;
>    106				break;
>    107			} else if (IS_ERR(dentry_page)) {
>    108				errln("fail to readdir of logical block %u of nid %llu",
>    109				      i, EROFS_V(dir)->nid);
>  > 110				err = -EFSCORRUPTED;
>    111				break;
>    112			}
>    113	
>    114			de = (struct erofs_dirent *)kmap(dentry_page);
>    115	
>    116			nameoff = le16_to_cpu(de->nameoff);
>    117	
>    118			if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
>    119				     nameoff >= PAGE_SIZE)) {
>    120				errln("%s, invalid de[0].nameoff %u",
>    121				      __func__, nameoff);
>    122	
>    123				err = -EIO;
>    124				goto skip_this;
>    125			}
>    126	
>    127			maxsize = min_t(unsigned int,
>    128					dirsize - ctx->pos + ofs, PAGE_SIZE);
>    129	
>    130			/* search dirents at the arbitrary position */
>    131			if (unlikely(initial)) {
>    132				initial = false;
>    133	
>    134				ofs = roundup(ofs, sizeof(struct erofs_dirent));
>    135				if (unlikely(ofs >= nameoff))
>    136					goto skip_this;
>    137			}
>    138	
>    139			err = erofs_fill_dentries(ctx, de, &ofs, nameoff, maxsize);
>    140	skip_this:
>    141			kunmap(dentry_page);
>    142	
>    143			put_page(dentry_page);
>    144	
>    145			ctx->pos = blknr_to_addr(i) + ofs;
>    146	
>    147			if (unlikely(err))
>    148				break;
>    149			++i;
>    150			ofs = 0;
>    151		}
>    152		return err < 0 ? err : 0;
>    153	}
>    154	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


