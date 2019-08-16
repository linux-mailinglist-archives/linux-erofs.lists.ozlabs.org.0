Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9D9098F
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 22:43:41 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 469Ff24mKnzDsNg
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Aug 2019 06:43:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1565988218;
	bh=BzACaEcckslKbH+pgoYZzB4wFf0ngDOg8fPRvW+Gn00=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GvNvsfLzu4jkwVxUFODM15UWLCWBrEwsYSOAHVGTNeC7gM1AADpbdFmCjFY65hJ2V
	 1RFqA1MChakv59cM3pV6EcFdhCKwMXHEo0MuoxrUGksXz7nNsTqhaWZyUDbsYF4wtR
	 0vZ3g4kf2v3WmejymAm3qpJAkmjttD6JfFZSIj0MKNYSAo7Q/KEbGKTC9Vf7ZFmGfG
	 0L11Ox19gmpZ+vgmGtDoe0ZXUKSSsUbnphV5UHkHGdWTHPIcVBVP8Hx6GSfyDX8rvZ
	 aFVwJHyaSSTfYkmtA4Hl+quiC7BcYfPVlJhwjjqobYETLeCJCStel7DRLst6Rrk4Ib
	 Q2HTGB1V71oMg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.83; helo=sonic305-21.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="f9nuUA5g"; 
 dkim-atps=neutral
Received: from sonic305-21.consmr.mail.ir2.yahoo.com
 (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 469Fdq3pZKzDsMm
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Aug 2019 06:43:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1565988197; bh=whvwKIyeI1JVi9QyewQJ+P/69MUMCMqb0YWGDkDw9Lw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=f9nuUA5gWyWFRYjpk2tQCQSVRhPb40q2Bo5VEfTbuH2ILi5nNGyYL6C8KQz5wlY94A4dkfys7Py6MS3HkNWQTG2lST2Om3oOL1YvfZamiVZ0bnyB6zxD7jiRESaDahGV7kiavo7Wp8LG4g29alud9EjY9BoBVo9X/E4b/mIgObaHqjxhmyEJylao1RpsB3Z0tynjMzYKItnCa4aKqvTV1qxPGISHiP9866Ev4lUgeokhnzqtYTUM0xL4lWYscHh+7XfEpLpOmXIMfxpxliOY6t4McXdFuRUrxejivagzaExbZQe+apAyrGiVX5rDBdvJZc+yEcF1VlEXjcq1XbLQRA==
X-YMail-OSG: O_6Ha7YVM1mnl8JbR9tzdt4gck7PksPZtqEhqIyRIu8e9g6q9OUW8XWWSJn26vF
 f.x2oWqfk.qmIN2nWGpVgVPfo4go9ZKMGjFRII3I3LndJCKdEaZGwsHtwe9I1lLjpV_k2xpdVLPm
 DzrHZj_xYhYJqrdyqa95b6z.1uUhhA1gCav5cbWIoFqWnpxF7PQARBn1EPvc7i.fLS2gqVDDaqDJ
 d_05LIkdbaJ5.K6SF3C0fzwERZrCVh.rQfSnWI.cPT03NJv3s5t2efZie66OA5Euhs1jVTWqTE2Y
 HKVc4exun25ya0AazcoqOpthmOgg_CaBi_k5da_oS3PUH2jzQYFc6lvz9gqZWcE.QvhQNqUUcZza
 LCRS90mN.87_N.KNSkrXTPPtyvgR557yj7D4ZGUk8CIJxtAUHfJOKXLHjZWjukT7to5uv.lfmn4J
 zWHtfc087Gj1Luwcg5bChv10G4yboCcwHH6z1cP7SMyDHOY.JGjWyqifaSKio9Q0L1WCPlZvD7Um
 VRrx5WhKdaNRPrFMjgUPmPEKccP8jW2uOJzws5Sx8OzaOMzDjhuPcl343YRHsyXGWB1nWMxzQ02a
 DTa4SLlPB818VkSQCxf9eX80hy9nKvk13MfFJ4RCywuDzSh5P.3sRzyt89Bl1ZREMC89qw1cG4Z7
 rGeUQd4W8DPzs7i0vPEONmMgZhSxWh3EGL9RiEkZ2gd0XVybwT2kHN.VRkoZ5.lPpR5TZ6ebHWPR
 mECzyIb14OWfdnNaMaqbAHLnzRYTRaUrN0WHMM7vozouvNYeX03lACwKtKlPb8d5HKe9_eAZ1BAC
 XsbBxXM0k8hKnevdRUrtlPFSuKw57quE9yI5FTtz8W5U0c9Hs9h61FY1V3cD8Z4WV.PMsGRwox29
 EmhuptHAb9RfMhIR49u56SeomZuqkLraHZp4K_AIHeUxGdYT_5_tfp3aDCZklaUnPXIiiLHMRsK0
 VoILWiq68L6oGG5Ae9OMt3c_FNVFyDAj91Wl4x_I277BzE0GwtXx82mu4Qx4SfA_iwHt4ofeFeeq
 uzj6r13hUBfXOAZuizgnxWY07eyP1KhJ6gj9YjONNqoM5K.rGUE9_Wohvrp2KWGzU.Z5qN_02B0V
 8Ya_tlZvkPjS3uQYbmRXV0Z1KY6BigiYQJdav1pYRjehZ94CERyZy.Q0p3Sw4zwlHyUifWhmTvlE
 hbDQIMoJ9s9UnsTFgThSNijEhAYMEhMwpdlefyzGztylAE9jfLfrFS9CWgVMXtVy0XJpGFECusyJ
 CMyZNcrHEg55DilX0csjmJIcefg3X
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.ir2.yahoo.com with HTTP; Fri, 16 Aug 2019 20:43:17 +0000
Received: by smtp427.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID df78473cfe9af2b8602db3d5234f3804; 
 Fri, 16 Aug 2019 20:43:14 +0000 (UTC)
Date: Sat, 17 Aug 2019 04:43:08 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH] erofs-utils: Fail the image creation when source path is
 not a directory file.
Message-ID: <20190816204307.GA3916@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190816085620.22266-1-pratikshinde320@gmail.com>
 <b6574e5c-22f8-02d1-bf0a-eeb81f300219@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6574e5c-22f8-02d1-bf0a-eeb81f300219@gmail.com>
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 16, 2019 at 11:36:24PM +0800, Li Guifu wrote:
> 
> ?? 2019/8/16 16:56, Pratik Shinde ????:
> > In the erofs.mkfs utility, if the source path is not a directory,image
> > creation should not proceed.since root of the filesystem needs to be a directory.
> > 
> > moving the check to main function.
> > 
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> 
> It looks good.
> Reviewed-by Li Guifu <blucerlee@gmail.com>

Fold in the original patch as well :)

Thanks,
Gao Xiang

> Thanks
> 
> 
> > ---
> >   mkfs/main.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 93cacca..8fbfced 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -12,6 +12,7 @@
> >   #include <stdlib.h>
> >   #include <limits.h>
> >   #include <libgen.h>
> > +#include <sys/stat.h>
> >   #include "erofs/config.h"
> >   #include "erofs/print.h"
> >   #include "erofs/cache.h"
> > @@ -187,6 +188,7 @@ int main(int argc, char **argv)
> >   	struct erofs_buffer_head *sb_bh;
> >   	struct erofs_inode *root_inode;
> >   	erofs_nid_t root_nid;
> > +	struct stat64 st;
> >   	erofs_init_configure();
> >   	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
> > @@ -197,6 +199,15 @@ int main(int argc, char **argv)
> >   			usage();
> >   		return 1;
> >   	}
> > +	err = lstat64(cfg.c_src_path, &st);
> > +	if (err)
> > +		return 1;
> > +	if ((st.st_mode & S_IFMT) != S_IFDIR) {
> > +		erofs_err("root of the filesystem is not a directory - %s",
> > +			  cfg.c_src_path);
> > +		usage();
> > +		return 1;
> > +	}
> >   	err = dev_open(cfg.c_img_path);
> >   	if (err) {
> > 
