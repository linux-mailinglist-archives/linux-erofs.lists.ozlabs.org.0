Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF261B1FD7
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2020 09:31:21 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495wGv1N89zDqyp
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2020 17:31:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1587454279;
	bh=tnbj5TxLy5u5z3p2HCM3hkgQNOU4cvRnpBRrHfaBKJE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PzWjs4jIwDZXHjLEl1wt4KmbH3su4//TKsQ8ELE7wReJQpfu0NdHoQ3ej7FvX25I/
	 DvFGBQYUKS58V36Qs8FtEcwFhlFCUsXtsYHqaCxzBawrvcDjy24jQ8zf2xM13ZH3k9
	 bjTOid+LL30D4erEQkrO82/7CV7IVYX/G5zJE72NCyNSxVp9AUE88PrmZ2iF+dyYOe
	 K6iIh549U8EZ9avhsDR3tXAy2QA3oYA8SxG1Qf/qvHwqCCP3sRhExnTuP9Uy1C12fC
	 zCWpO9cwNU/O1IFOjR1SrhoawqfKLc/yXk3RABY31oenuy/CoE+2U63d1P1eMG98ce
	 KNFGQAQPOY4vw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=66.163.184.175; helo=sonic309-49.consmr.mail.ne1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=KpaZLk24; dkim-atps=neutral
Received: from sonic309-49.consmr.mail.ne1.yahoo.com
 (sonic309-49.consmr.mail.ne1.yahoo.com [66.163.184.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495wGg6L1gzDqy1
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2020 17:31:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1587454261; bh=8SaBe657SUqzMIHOQXCqE8E7juFfQ/VceplMPZo+D8w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=KpaZLk24UVqPwIBYC2dgf14lue+EQnfVzZFTJmxMC6TsT7WKiMhtq08Fetju5nTIV7GNbh+7nSybfvPnBgN8i47khQXY2HmIZwMOVXi4SCV3ErhFWLgDWLc2qBmEGV/6gKpYAGFLOSpKngk5Fx2V55XG7FOC/CX3KhYAWpkwIEl+fBOolBaLqdW199swuNwiic9emeccaeytk3kqWy82b4F21pRQo4rUC1hG14VNbemWbF7qNmIuidaA/IETfF1jZ+UTturFaZOLzhTfNo+5e2YDhl/8PsxH+52Lu72oiczyuSUxS+PZ3ZjnFSgA0E0917mBCFV3SeEDzDu6/f1cVQ==
X-YMail-OSG: ZLEfS2sVM1lk0I6iQYW5PaC27I6c61k7i1jV62cC4k.LmLL85pmV5Bd1SzzocJs
 sRfj94Pu4n3wFv1H_bhWjKvopCKSTupX0RCYaDhBaUw4l2N0pSafWoYv1p7Gw8PadYcrpqeTJkmo
 x.vFg3ICrxKeHJe5A2VjBgVUEF_eugMhyT2Kzqr946MYTvBF0X25MXIHn.W6.2gGmuFxfVNfaJbk
 wf1cvUYnRTlz9VbmQ8jqsBWcWWybpFhhWarQb6ys_3OK4WNIHvOc4acXtDGYtFUo9mGbPDdixfii
 .HyxC5mNMUnl7mF5dDGXJk.NzpSa9FZzkes7m9A7H764xLIzf5hXzgHq73Dw8qQTc6ZysClNsbE7
 Cqg9zJzR_MaVhtU0.wAbKgwJzQHR1iJ55jaOcg0byMOZ0uoQBJAH6TuYXoONFmR8od58M32mpPWr
 kURn0vEpDgo6ziJSLwNCffWjfg29YmK5biUHIxwVkaZMtJMwypJqiKONdSszFXqeKZfkZ43yMVzk
 NPsOGpF.B8McUrusJ8bU8V5_Pw64P2MzyRG_xOqHU4PEVJ8QcHSUKutvC17bM3hlbXN2URZlENMd
 d8Vf1DHE0kXtkkPZ4VOiSoIDBZgLuWkasmiahU4upu6la7rTzo9lzmbxZtBgCASkn1ZknrsBuanq
 s4gwFJJjx5JRJ0M1OfPm.ljypeTz2C8k.2sDFGlFcZsVpIqoi40CLTwWZeDTLPR4EziHpb3AWhiQ
 Wny4DBpwdRD7gPOjsiGO6w9OZAtrGiJd3daH7ELv6V9EsinNln6wYjpf.P03ZtSSeGVjLpj3gwC5
 4ZQ6xDPuavzeSH5cPOYSWdDTfO.IUhjmAJhRjKlmSu6B5Wa6rtLrtlScqypRMQAKGuAV8YduU5KI
 8eYtkpmUVzCmZgEhtfKGxS2GYC7jxikiAGdV2ElykH1jwQOXG9_6MJeHgM_S7wG.sIVzW5BvY46S
 U3gM0PK5AVuKU8r8W4jpC5_MOIUbRM1UFWE9AR4pGtumwfhniOhER3TyiCVZI2xKHrkD432P83Gd
 mZN3fPspYLogkNTC4Pp5BnehwQnuS7.Q1LEDG7K4yXIHWEWw5JIZ46YoZm5pXFYVnPVa0w84MN_.
 8ErDK4fqws8tDW_ASdgJBiWOupx35rpfu.rPF2224lydresvTjLnTIf8lFnhXN7BgaLoaBZcuELo
 7d7.6T.VinNDGuXqbdmE_ducuAYaeJ7cmmW3_ZpH5nIJXxXTPL1SLIUhl1cz6mcX_baEL4kuRe7G
 QBHv3bahyaZqtCrIWnR0n7wmtRNy2FEYSnHq3oUlt19LRQgWfoZcQe_GuDMFKfNB5Pxuoy3b4KVt
 CFMHhQXta0y6ZgvoOw5i9EEPCWKsh5_gwAwF5XcK3wkcG3LGE6p37DRvSe3ZA6rk.EbJd2mEQghM
 kIyy4lSay2M49R9IvFN5a5UPkXOLi14eHbk.8BNbLJhtErNaT725b8ay_JaMv_czB0ue.SfOtgpY
 XWyRQdpzwRYjzGhxb6.MNFQCTSQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Apr 2020 07:31:01 +0000
Received: by smtp407.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 98aed6c61d98e300b5dca39559149029; 
 Tue, 21 Apr 2020 07:28:59 +0000 (UTC)
Date: Tue, 21 Apr 2020 15:28:51 +0800
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 19/25] erofs: Convert compressed files from readpages
 to readahead
Message-ID: <20200421072839.GA13867@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-20-willy@infradead.org>
 <20200420224210.dff005bc62957a4d81d58226@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420224210.dff005bc62957a4d81d58226@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15739 hermes Apache-HttpAsyncClient/4.1.4
 (Java/11.0.6)
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
Cc: cluster-devel@redhat.com, Gao Xiang <gaoxiang25@huawei.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-btrfs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Andrew,

On Mon, Apr 20, 2020 at 10:42:10PM -0700, Andrew Morton wrote:
> On Tue, 14 Apr 2020 08:02:27 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > 
> > Use the new readahead operation in erofs.
> > 
> 
> Well this is exciting.
> 
> fs/erofs/data.c: In function erofs_raw_access_readahead:
> fs/erofs/data.c:149:18: warning: last_block may be used uninitialized in this function [-Wmaybe-uninitialized]
> 	*last_block + 1 != current_block) {
> 
> It seems to be a preexisting bug, which your patch prompted gcc-7.2.0
> to notice.
> 
> erofs_read_raw_page() goes in and uses *last_block, but neither of its
> callers has initialized it.  Could the erofs maintainers please take a
> look?

simply because last_block doesn't need to be initialized at first,
because bio == NULL in the begining anyway. I believe this is a gcc
false warning because some gcc versions raised some before (many gccs
don't, including my current gcc (Debian 8.3.0-6) 8.3.0).

in detail,

146         /* note that for readpage case, bio also equals to NULL */
147         if (bio &&
148             /* not continuous */
149             *last_block + 1 != current_block) {
150 submit_bio_retry:
151                 submit_bio(bio);
152                 bio = NULL;
153         }

bio will be NULL and will bypass the next condition at first.
after that,

155         if (!bio) {

...

221                 bio = bio_alloc(GFP_NOIO, nblocks);

...

}

...

230         err = bio_add_page(bio, page, PAGE_SIZE, 0);
231         /* out of the extent or bio is full */
232         if (err < PAGE_SIZE)
233                 goto submit_bio_retry;
234
235         *last_block = current_block;

so bio != NULL, and last_block will be assigned then as well.

Thanks,
Gao Xiang


