Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A006D1134
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 16:27:43 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46pGlJ02ygzDqSy
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2019 01:27:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570631260;
	bh=Dfjz0yvEu55Cg29q/8nQJUV07XeKnVt0R1u2YGtZuXg=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lXdleuIEhinKp2+HWUo+zWnr5tBAB9+iD8g608h6OUNVZGpN8ZX7uIGtKYlPWbPHm
	 EBFQ94PIdmg4Aq3SAdJ0Bhi/MlE9NXP/2LbohQBXJNz1NvyC4FJfToimuI7ht0Q5tn
	 fmsEjRLTAUN/FxnxX2tGW4tkE7JbccARHMeCJ3zrHoEYtiOBDQGpRXH6TYOkshtOlt
	 hHTK7FMVpfWQNya45lo8v2blhqcGX1Rnccfps8xk1Z8LR+tJ6mgwSOVeI032XHIuOu
	 TY903XFB3mUfISAng5e+TpCcrm1aA7S8PwZEi4sqG/X+XamTF1TeEk3Qy0N4GAqsY5
	 AGI97bOnxPiGg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.31; helo=sonic307-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="krUzpcvu"; 
 dkim-atps=neutral
Received: from sonic307-55.consmr.mail.gq1.yahoo.com
 (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46pGky2Ld1zDqFt
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2019 01:27:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570631236; bh=nQqsmtOgqUyNZRWUflsKb7f2dr7dZEO7uwnsUFRUl+8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=krUzpcvuT5bEWH3PFcwAs5xe3rRHlWnXZ+Rkmgv4SC11usyh9vvxDXIC7axtxAr6Ggqhyp/cDttLPRWSTVAIj7U9ZU3Ax5Z7gI0E8WZwflHYSUDklPi1qUIYl93WaGmBv6HCh9JmpBr9UYpcyOBBBuRMttQl7ysm5ZYf7H+sMN3UhtN+1mF5IE8jmoXMzxRBatKGmI9WluP9RG+ktGQ6SyRB8Chxh6m/ndvgWxFbBj0fiNga8gsawq2LPTx5eQXIgRv53E8brb4UHp6zn8n8c3+MCwHp3pe5gQ8yDDZjrECb3Y+44KqctnM8U0VEwnQpCjZoTl0lmmCi5PN3gcmzxw==
X-YMail-OSG: SXggmf8VM1mFHeO8cKuat3ACcK_6USsFWv31xSZXUjNKE7CmqjXSp3.qWgu0Z.H
 swrZAhQsrvcvQ9qcY1aXBGcjzMf8VJFcjBXzw8u5umTb9i_I3rRSoEGRphcusWKe43OObpmldJec
 BNIIQy1MmcXz6uFPl7SJI5WDquO_vrgehZKwbPWBHojmzLXdetva2QI6sfAwIddfPlCF.U2RzCNE
 Fb2vdG4Z0pkt0wjzc017EwT7M9vdErwOWEp6u_tp1wY47.Zr4s0pblMPiILuvNMM3H08aq6FSgjq
 BxWSbuFzrzJ39WhFFphVoRFNcK9amvpDre3rxm89Ec0Q.Khj3YlIaLMydsdydEWimPNlqcdMFxiv
 eoIcPO6QbPbJU40UTchb0Wv7WcSulhdhkCWwom1a7Hb771zU23LZMrSVU1CW47UzLWFmNDe9ncEO
 pIFalzRj_ejtK0fAgiRraFt5o3RlKgglM6cv0buSbcPopsWDLyR9AbXyxvnyQ8SLtwozq6qj.amA
 C3q.0cAnATCUdVE64z3fDtO5l88iaMVh8_xtv9jq9rts5kSeWjLpnvotgLBkofd1.oXh7sR3S5Oz
 R6e45lw6cQnzcg9JPVP3hkDmEPMP0ikwiZCRONcHvSbjOFb4u1L60VP.GN2NlvXsR2gUde4Wncde
 ubXctoSSJCSy97aYuOh3sYc6EnbKdDDqAWkLHqPfzb_6xwS7XsSO9phJ8AjIkmqO1R9he3n.cJB4
 arxJWEwMDTCldju7BnfJdATqecWK24YzmvMjl.JGyM73o6t_09CtNAdpgIqwbCZsrtrtfv0qwl30
 yKD5sNB3aTiZ5oBasibPILxCwcnhlQax9SAx3GvTTRCu0sWmmVMlZXtIRagWe1CKSRj70_Ju8tG5
 U5k45F.pvMWQ0.zLwwAGH5fFDYpXZKa5dz4hRSB_uSZI.Qr2OtlIG7z6wAifk63TGQ7onGfnxpUj
 4lOo2SUhHdAchztIEsmHjHmdnr3JcxaZlkqvL_ufWfNsh7DrtIRQT1pYuQp.R8JMVArDV2uTiq90
 2jncnOb86KkqTwgGayIA.NORmDFXazaSOMSWwLNqJC_KJSmhRkctRBfjKQ76bI5DjXHR0VZ4jf9B
 HjuBLhUc1AJXNtCsybYwpcgTZCZHsxyaTV9sCouOGdqWzwHog2KX0fIzxY21ol8qtFjU..3KMVj7
 5rgXlv7.7VaHMRspzArtnVRb4cHU5cNwu6fMTguGY2oFWlRbT1DtQQtJHgEJOvglg8xKLOJ2hYYA
 MR8v8rhcbYQSd3GautLEPNFVLqAewHN8UGo0edzqYYP69AMwpJiNfmjNXEpijhlFuQlvFk8lAbAM
 k0H9YToo-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Wed, 9 Oct 2019 14:27:16 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 94e60346295ac1f571459a5056fb2294; 
 Wed, 09 Oct 2019 14:27:16 +0000 (UTC)
Date: Wed, 9 Oct 2019 22:27:04 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
Message-ID: <20191009142651.GA29753@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190824123803.19797-1-pratikshinde320@gmail.com>
 <20190824140012.GB19943@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSznsz7w90okOKa4bXhfy3ou4X=7pHKLmWw4WffFVh5wQ@mail.gmail.com>
 <20191006053914.GA25306@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czStB-4eraf_b-YvzzF_2E=c3bBvK0DGc031M=vyvLaeWQ@mail.gmail.com>
 <20191009065728.GA118670@architecture4>
 <CAGu0czQdWeYiTKJnQTpM3vvJ8H809bg_L33qebKDNbA9705sMg@mail.gmail.com>
 <20191009084801.GA130892@architecture4>
 <CAGu0czSkCwvX5ZQ8Y9F6WjJDbOLYuHuEsaYZXFh5rrqmB3Jyew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czSkCwvX5ZQ8Y9F6WjJDbOLYuHuEsaYZXFh5rrqmB3Jyew@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Wed, Oct 09, 2019 at 07:44:08PM +0530, Pratik Shinde wrote:
> Hello Gao,
> 
> I have few questions regarding the checksum feature:
> 1) Are we still keeping it as a feature. (i.e enabled by default . but can
> be disabled during mkfs)

Yes, I think it should be a new compatible feature suggested by Richard
and enabled by default (this feature should be marked in on-disk
super_block...)

> 2) For small images we are going to cksum the entire image. what could be
> the maximum size of 'small' images.

I think we can checksum the first 4k for now in mkfs by default
(or only checksum 4k as the first step), and then it can be
configured to a larger number n*4k. (But for the kernel side,
it has to be fully implemented due to forward compatibility.)

> 
> also, I think we don't have routines to read buffers back into the memory.
> I will write them first and send a patch.

Yes, I remembered that you once wrote a similar function, that is ok.
And it's no rush, we have more than a month to develop pending features
for linux-5.5. Just a reminder because we can prepare them for now :)

Thanks,
Gao Xiang

> 
> -Pratik
> 
> On Wed, Oct 9, 2019 at 2:14 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
> > Hi Pratik,
> >
> > On Wed, Oct 09, 2019 at 01:54:40PM +0530, Pratik Shinde wrote:
> > > Hello Gao,
> > >
> > > Yes I would like to work on pending features.
> > > Also please let us know the new development items.
> >
> > Thanks, I will post later after gathering the first round
> > suggestions to mailing lists. We have time to improve this
> > filesystem. :)
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > --Pratik
> > >
> > > On Wed, 9 Oct, 2019, 12:24 PM Gao Xiang, <gaoxiang25@huawei.com> wrote:
> > >
> > > > Hi Pratik,
> > > >
> > > > On Wed, Oct 09, 2019 at 11:59:01AM +0530, Pratik Shinde wrote:
> > > > > Hi Gao,
> > > > >
> > > > > Yes I can work on it. Sorry I missed this mail. I think your
> > approach is
> > > > > good. Let me go through it one more time and reply back.
> > > >
> > > > Thanks for your reply and interest :)
> > > > I think we can complete all pending features together
> > > > if you have some time on this stuff. (fsdebug utility is
> > > > on the way as well...)
> > > >
> > > > BTW, I'm now investigating new high CR algorithm (very likely
> > > > XZ) as well, it will be likely a RFC version in this round for
> > > > wider scenarios and later decompression subsystem.
> > > >
> > > > Preliminary TODO lists will be discussed in this year China
> > > > Linux Storage & Filesystem workshop (next week) and will be
> > > > posted to mailing lists for further wider discussion (if more
> > > > folks have interest in developing it) as well. :)
> > > >
> > > > Thanks,
> > > > Gao Xiang
> > > >
> > > > >
> > > > > --Pratik
> > > > >
> > > > > On Sun, 6 Oct, 2019, 11:09 AM Gao Xiang, <hsiangkao@aol.com> wrote:
> > > > >
> > > > > > Hi Pratik,
> > > > > >
> > > > > > On Sat, Aug 24, 2019 at 08:26:28PM +0530, Pratik Shinde wrote:
> > > > > > > Hi Gao,
> > > > > > >
> > > > > > > I completely understand your concern.You can drop this patch for
> > now.
> > > > > > > Once erofs makes it 'fs/' please do reconsider implementing it.
> > > > > >
> > > > > > I think we can work on this pending feature for v5.5 now.
> > > > > > My idea is to add an extra field in erofs_super_block to
> > > > > > indicate the number of blocks (4k) for checking.
> > > > > >
> > > > > > So for small images, this feature can checksum the whole image at
> > mount
> > > > > > time,
> > > > > > and for large images, this feature can be used to checksum the
> > super
> > > > block
> > > > > > only
> > > > > > (and then use verficiation subsystem to verify on-the-fly in the
> > > > future...)
> > > > > >
> > > > > > The following workflow is for erofs-utils, I think it's
> > > > > >  1) erofs_mkfs_update_super_block with checksum = 0
> > > > > >  2) erofs_bflush(NULL)
> > > > > >  3) reread the corresponding blocks and calculate checksum;
> > > > > >  4) write checksum to erofs_super_block;
> > > > > >
> > > > > > Does it sound reasonable? and do you still have interest and
> > > > > > time for this? Looking forword to your reply...
> > > > > >
> > > > > > Thanks,
> > > > > > Gao Xiang
> > > > > >
> > > > > > >
> > > > > > > One more thing, can we still send non feature patches?
> > > > > > >
> > > > > > > --Pratik
> > > > > > >
> > > > > > >
> > > > > > > On Sat, 24 Aug, 2019, 7:30 PM Gao Xiang, <hsiangkao@aol.com>
> > wrote:
> > > > > > >
> > > > > > > > Hi Pratik,
> > > > > > > >
> > > > > > > > On Sat, Aug 24, 2019 at 06:08:03PM +0530, Pratik Shinde wrote:
> > > > > > > > > Adding code for superblock checksum calculation.
> > > > > > > > >
> > > > > > > > > incorporated the changes suggested in previous patch.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > > > > >
> > > > > > > > Thanks for your v2 patch.
> > > > > > > >
> > > > > > > > Actually, I have some concern about the length of checksum,
> > > > > > > > sizeof(struct erofs_super_block) could be changed in the
> > > > > > > > later version, it's bad for EROFS future scalablity.
> > > > > > > >
> > > > > > > > And I tend not to add another on-disk field to record
> > > > > > > > the size of erofs_super_block as well, because the old
> > > > > > > > Linux kernel cannot handle more about the new size,
> > > > > > > > so it has little use except for checksum calculation.
> > > > > > > >
> > > > > > > > Few hours ago, I discussed with Chao about this concern,
> > > > > > > > I think this feature can be changed to do multiple-block
> > > > > > > > checksum at the mount time, e.g:
> > > > > > > >  - for small images, we can check the whole image once
> > > > > > > >    at the mount time;
> > > > > > > >  - for the large image, we can check the superblock
> > > > > > > >    at the mount time, the rest can be handled by
> > > > > > > >    block-based verification layer.
> > > > > > > >
> > > > > > > > But we agreed that don't add this for this round
> > > > > > > > since it's quite a new feature.
> > > > > > > >
> > > > > > > > All in all, it's a new feature since we are addressing moving
> > > > > > > > out of staging for this round. I tend to postpone this feature
> > > > > > > > for now. I understand that you are very interested in EROFS.
> > > > > > > > Considering EROFS current staging status, it's not such a place
> > > > > > > > to add new features at all! I have marked your patch down and
> > > > > > > > I will work with you later. Hope to get your understanding...
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Gao Xiang
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > >  include/erofs/config.h |  1 +
> > > > > > > > >  include/erofs_fs.h     | 10 ++++++++
> > > > > > > > >  mkfs/main.c            | 64
> > > > > > > > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > > > > > > > >  3 files changed, 74 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > > > > > > > > index 05fe6b2..40cd466 100644
> > > > > > > > > --- a/include/erofs/config.h
> > > > > > > > > +++ b/include/erofs/config.h
> > > > > > > > > @@ -22,6 +22,7 @@ struct erofs_configure {
> > > > > > > > >       char *c_src_path;
> > > > > > > > >       char *c_compr_alg_master;
> > > > > > > > >       int c_compr_level_master;
> > > > > > > > > +     int c_feature_flags;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  extern struct erofs_configure cfg;
> > > > > > > > > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > > > > > > > > index 601b477..9ac2635 100644
> > > > > > > > > --- a/include/erofs_fs.h
> > > > > > > > > +++ b/include/erofs_fs.h
> > > > > > > > > @@ -20,6 +20,16 @@
> > > > > > > > >  #define EROFS_REQUIREMENT_LZ4_0PADDING       0x00000001
> > > > > > > > >  #define EROFS_ALL_REQUIREMENTS
> > > > > > > >  EROFS_REQUIREMENT_LZ4_0PADDING
> > > > > > > > >
> > > > > > > > > +/*
> > > > > > > > > + * feature definations.
> > > > > > > > > + */
> > > > > > > > > +#define EROFS_DEFAULT_FEATURES
> > > >  EROFS_FEATURE_SB_CHKSUM
> > > > > > > > > +#define EROFS_FEATURE_SB_CHKSUM              0x0001
> > > > > > > > > +
> > > > > > > > > +
> > > > > > > > > +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \
> > > > > > > > > +     ( le32_to_cpu((super)->features) & (mask) )
> > > > > > > > > +
> > > > > > > > >  struct erofs_super_block {
> > > > > > > > >  /*  0 */__le32 magic;           /* in the little endian */
> > > > > > > > >  /*  4 */__le32 checksum;        /* crc32c(super_block) */
> > > > > > > > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > > > > > > > index f127fe1..355fd2c 100644
> > > > > > > > > --- a/mkfs/main.c
> > > > > > > > > +++ b/mkfs/main.c
> > > > > > > > > @@ -31,6 +31,45 @@ static void usage(void)
> > > > > > > > >       fprintf(stderr, " -EX[,...] X=extended options\n");
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +#define CRCPOLY      0x82F63B78
> > > > > > > > > +static inline u32 crc32c(u32 seed, unsigned char const *in,
> > > > size_t
> > > > > > len)
> > > > > > > > > +{
> > > > > > > > > +     int i;
> > > > > > > > > +     u32 crc = seed;
> > > > > > > > > +
> > > > > > > > > +     while (len--) {
> > > > > > > > > +             crc ^= *in++;
> > > > > > > > > +             for (i = 0; i < 8; i++) {
> > > > > > > > > +                     crc = (crc >> 1) ^ ((crc & 1) ?
> > CRCPOLY :
> > > > 0);
> > > > > > > > > +             }
> > > > > > > > > +     }
> > > > > > > > > +     erofs_dump("calculated crc: 0x%x\n", crc);
> > > > > > > > > +     return crc;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +char *feature_opts[] = {
> > > > > > > > > +     "nosbcrc", NULL
> > > > > > > > > +};
> > > > > > > > > +#define O_SB_CKSUM   0
> > > > > > > > > +
> > > > > > > > > +static int parse_feature_subopts(char *opts)
> > > > > > > > > +{
> > > > > > > > > +     char *arg;
> > > > > > > > > +
> > > > > > > > > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > > > > > > > > +     while (*opts != '\0') {
> > > > > > > > > +             switch(getsubopt(&opts, feature_opts, &arg)) {
> > > > > > > > > +             case O_SB_CKSUM:
> > > > > > > > > +                     cfg.c_feature_flags |=
> > > > > > (~EROFS_FEATURE_SB_CHKSUM);
> > > > > > > > > +                     break;
> > > > > > > > > +             default:
> > > > > > > > > +                     erofs_err("incorrect suboption");
> > > > > > > > > +                     return -EINVAL;
> > > > > > > > > +             }
> > > > > > > > > +     }
> > > > > > > > > +     return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int parse_extended_opts(const char *opts)
> > > > > > > > >  {
> > > > > > > > >  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > > > > > > > @@ -79,7 +118,8 @@ static int mkfs_parse_options_cfg(int
> > argc,
> > > > char
> > > > > > > > *argv[])
> > > > > > > > >  {
> > > > > > > > >       int opt, i;
> > > > > > > > >
> > > > > > > > > -     while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> > > > > > > > > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > > > > > > > > +     while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
> > > > > > > > >               switch (opt) {
> > > > > > > > >               case 'z':
> > > > > > > > >                       if (!optarg) {
> > > > > > > > > @@ -113,6 +153,12 @@ static int mkfs_parse_options_cfg(int
> > argc,
> > > > char
> > > > > > > > *argv[])
> > > > > > > > >                               return opt;
> > > > > > > > >                       break;
> > > > > > > > >
> > > > > > > > > +             case 'O':
> > > > > > > > > +                     opt = parse_feature_subopts(optarg);
> > > > > > > > > +                     if (opt)
> > > > > > > > > +                             return opt;
> > > > > > > > > +                     break;
> > > > > > > > > +
> > > > > > > > >               default: /* '?' */
> > > > > > > > >                       return -EINVAL;
> > > > > > > > >               }
> > > > > > > > > @@ -144,6 +190,15 @@ static int mkfs_parse_options_cfg(int
> > argc,
> > > > char
> > > > > > > > *argv[])
> > > > > > > > >       return 0;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> > > > > > > > > +{
> > > > > > > > > +     u32 crc;
> > > > > > > > > +     crc = crc32c(~0, (const unsigned char *)sb,
> > > > > > > > > +                 sizeof(struct erofs_super_block));
> > > > > > > > > +     erofs_dump("superblock checksum: 0x%x\n", crc);
> > > > > > > > > +     return crc;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  int erofs_mkfs_update_super_block(struct erofs_buffer_head
> > *bh,
> > > > > > > > >                                 erofs_nid_t root_nid)
> > > > > > > > >  {
> > > > > > > > > @@ -155,6 +210,7 @@ int erofs_mkfs_update_super_block(struct
> > > > > > > > erofs_buffer_head *bh,
> > > > > > > > >               .meta_blkaddr  = sbi.meta_blkaddr,
> > > > > > > > >               .xattr_blkaddr = 0,
> > > > > > > > >               .requirements = cpu_to_le32(sbi.requirements),
> > > > > > > > > +             .features = cpu_to_le32(cfg.c_feature_flags),
> > > > > > > > >       };
> > > > > > > > >       const unsigned int sb_blksize =
> > > > > > > > >               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > > > > > > > > @@ -169,6 +225,12 @@ int erofs_mkfs_update_super_block(struct
> > > > > > > > erofs_buffer_head *bh,
> > > > > > > > >       sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
> > > > > > > > >       sb.root_nid     = cpu_to_le16(root_nid);
> > > > > > > > >
> > > > > > > > > +     if (EROFS_HAS_COMPAT_FEATURE(&sb,
> > > > EROFS_FEATURE_SB_CHKSUM)) {
> > > > > > > > > +             sb.checksum = 0;
> > > > > > > > > +             u32 crc = erofs_superblock_checksum(&sb);
> > > > > > > > > +             sb.checksum = cpu_to_le32(crc);
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > >       buf = calloc(sb_blksize, 1);
> > > > > > > > >       if (!buf) {
> > > > > > > > >               erofs_err("Failed to allocate memory for sb:
> > %s",
> > > > > > > > > --
> > > > > > > > > 2.9.3
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >
