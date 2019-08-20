Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C148957BB
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 08:58:14 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CM7l2MyLzDqd1
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 16:58:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=philip.li@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CM7g3MhZzDqcJ
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2019 16:58:06 +1000 (AEST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Aug 2019 23:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,407,1559545200"; d="scan'208";a="262076234"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga001.jf.intel.com with ESMTP; 19 Aug 2019 23:58:02 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 19 Aug 2019 23:58:02 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 19 Aug 2019 23:58:02 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.163]) with mapi id 14.03.0439.000;
 Tue, 20 Aug 2019 14:58:00 +0800
From: "Li, Philip" <philip.li@intel.com>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: RE: [PATCH] staging: erofs: fix an error handling in erofs_readdir()
Thread-Topic: [PATCH] staging: erofs: fix an error handling in erofs_readdir()
Thread-Index: AQHVVciSAydYtdJuwUarX+BT1XqKVqcDFXgA////3wCAAIa24A==
Date: Tue, 20 Aug 2019 06:58:00 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E66249520C70FE@shsmsx102.ccr.corp.intel.com>
References: <20190818031855.9723-1-hsiangkao@aol.com>
 <201908182116.RRufKUpl%lkp@intel.com>
 <20190818132503.GA26232@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190820065038.GG4479@intel.com> <20190820065010.GG159846@architecture4>
In-Reply-To: <20190820065010.GG159846@architecture4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDcxM2U4NjEtNmJjNS00OWM4LTllYjgtYzNhZmJhMjQwY2JlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS0YrbEh1azRwaVQ0b0RWbSszQVwvSHNpNVZqNmpGK0hHTjh5Z2l5TndJMFhYdWFWVE10S0txTHdJOWRFZ2dxcWcifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 lkp <lkp@intel.com>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kbuild-all@01.org" <kbuild-all@01.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> Subject: Re: [PATCH] staging: erofs: fix an error handling in erofs_readd=
ir()
>=20
> Hi Philip,
>=20
> On Tue, Aug 20, 2019 at 02:50:38PM +0800, Philip Li wrote:
> > On Sun, Aug 18, 2019 at 09:25:04PM +0800, Gao Xiang wrote:
> > > On Sun, Aug 18, 2019 at 09:17:52PM +0800, kbuild test robot wrote:
> > > > Hi Gao,
> > > >
> > > > I love your patch! Yet something to improve:
> > > >
> > > > [auto build test ERROR on linus/master]
> > > > [cannot apply to v5.3-rc4 next-20190816]
> > > > [if your patch is applied to the wrong git tree, please drop us a n=
ote to help
> improve the system]
> > >
> > > ... those patches should be applied to staging tree
> > > since linux-next has not been updated yet...
> > thanks for the feedback, we will consider this to our todo list.
>=20
> Yes, many confusing reports anyway...
> (Just my personal suggestion, maybe we can add some hints on the patch em=
ail
> to indicate which tree can be applied successfully for ci in the future..=
.)
thanks, this is good idea. On the other side, we support to add --base opti=
on to git format-patch
to automatically suggest the base, refer to https://stackoverflow.com/a/374=
06982 for detail.
Meanwhile, we will enhance the internal logic to find suitable base if poss=
ible.

>=20
> Thanks,
> Gao Xiang
>=20
> >
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > >
> > > > url:    https://github.com/0day-ci/linux/commits/Gao-Xiang/staging-=
erofs-fix-
> an-error-handling-in-erofs_readdir/20190818-191344
> > > > config: arm64-allyesconfig (attached as .config)
> > > > compiler: aarch64-linux-gcc (GCC) 7.4.0
> > > > reproduce:
> > > >         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # save the attached .config to linux build tree
> > > >         GCC_VERSION=3D7.4.0 make.cross ARCH=3Darm64
> > > >
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    drivers/staging/erofs/dir.c: In function 'erofs_readdir':
> > > > >> drivers/staging/erofs/dir.c:110:11: error: 'EFSCORRUPTED' undecl=
ared
> (first use in this function); did you mean 'FS_NRSUPER'?
> > > >        err =3D -EFSCORRUPTED;
> > > >               ^~~~~~~~~~~~
> > > >               FS_NRSUPER
> > > >    drivers/staging/erofs/dir.c:110:11: note: each undeclared identi=
fier is
> reported only once for each function it appears in
> > > >
> > > > vim +110 drivers/staging/erofs/dir.c
> > > >
> > > >     85
> > > >     86	static int erofs_readdir(struct file *f, struct dir_context =
*ctx)
> > > >     87	{
> > > >     88		struct inode *dir =3D file_inode(f);
> > > >     89		struct address_space *mapping =3D dir->i_mapping;
> > > >     90		const size_t dirsize =3D i_size_read(dir);
> > > >     91		unsigned int i =3D ctx->pos / EROFS_BLKSIZ;
> > > >     92		unsigned int ofs =3D ctx->pos % EROFS_BLKSIZ;
> > > >     93		int err =3D 0;
> > > >     94		bool initial =3D true;
> > > >     95
> > > >     96		while (ctx->pos < dirsize) {
> > > >     97			struct page *dentry_page;
> > > >     98			struct erofs_dirent *de;
> > > >     99			unsigned int nameoff, maxsize;
> > > >    100
> > > >    101			dentry_page =3D read_mapping_page(mapping, i,
> NULL);
> > > >    102			if (dentry_page =3D=3D ERR_PTR(-ENOMEM)) {
> > > >    103				errln("no memory to readdir of logical
> block %u of nid %llu",
> > > >    104				      i, EROFS_V(dir)->nid);
> > > >    105				err =3D -ENOMEM;
> > > >    106				break;
> > > >    107			} else if (IS_ERR(dentry_page)) {
> > > >    108				errln("fail to readdir of logical block %u of
> nid %llu",
> > > >    109				      i, EROFS_V(dir)->nid);
> > > >  > 110				err =3D -EFSCORRUPTED;
> > > >    111				break;
> > > >    112			}
> > > >    113
> > > >    114			de =3D (struct erofs_dirent *)kmap(dentry_page);
> > > >    115
> > > >    116			nameoff =3D le16_to_cpu(de->nameoff);
> > > >    117
> > > >    118			if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
> > > >    119				     nameoff >=3D PAGE_SIZE)) {
> > > >    120				errln("%s, invalid de[0].nameoff %u",
> > > >    121				      __func__, nameoff);
> > > >    122
> > > >    123				err =3D -EIO;
> > > >    124				goto skip_this;
> > > >    125			}
> > > >    126
> > > >    127			maxsize =3D min_t(unsigned int,
> > > >    128					dirsize - ctx->pos + ofs,
> PAGE_SIZE);
> > > >    129
> > > >    130			/* search dirents at the arbitrary position */
> > > >    131			if (unlikely(initial)) {
> > > >    132				initial =3D false;
> > > >    133
> > > >    134				ofs =3D roundup(ofs, sizeof(struct
> erofs_dirent));
> > > >    135				if (unlikely(ofs >=3D nameoff))
> > > >    136					goto skip_this;
> > > >    137			}
> > > >    138
> > > >    139			err =3D erofs_fill_dentries(ctx, de, &ofs, nameoff,
> maxsize);
> > > >    140	skip_this:
> > > >    141			kunmap(dentry_page);
> > > >    142
> > > >    143			put_page(dentry_page);
> > > >    144
> > > >    145			ctx->pos =3D blknr_to_addr(i) + ofs;
> > > >    146
> > > >    147			if (unlikely(err))
> > > >    148				break;
> > > >    149			++i;
> > > >    150			ofs =3D 0;
> > > >    151		}
> > > >    152		return err < 0 ? err : 0;
> > > >    153	}
> > > >    154
> > > >
> > > > ---
> > > > 0-DAY kernel test infrastructure                Open Source Technol=
ogy Center
> > > > https://lists.01.org/pipermail/kbuild-all                   Intel C=
orporation
> > >
> > >
