Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 921F041A992
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 09:17:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJW753RqPz3cPp
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 17:17:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=DIATSXRB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=szeredi.hu (client-ip=2607:f8b0:4864:20::e2d;
 helo=mail-vs1-xe2d.google.com; envelope-from=miklos@szeredi.hu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="key not found in DNS" header.d=szeredi.hu
 header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=DIATSXRB; 
 dkim-atps=neutral
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJW6s3Xv3z3cMj
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 17:17:39 +1000 (AEST)
Received: by mail-vs1-xe2d.google.com with SMTP id q66so21021159vsa.4
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5VZceE/dQmU6bLvl6P5d+DLar0Sw2Dsq3q/ylCWAUVI=;
 b=DIATSXRBLGAqa+xswEPNBQnleXtV60+haTfFNrEmgJvJaoAll70jM44RaWWm8u0qYt
 82EyP2C1R1uHBrniA+rW8Rbfsf5K2erg6ezXvTLWSqE0CEqXv+12jhh+0+1EeEL8pjIh
 OTL3Ixk0I9sDGkcH3RFolHamWqvWcV3ocipko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5VZceE/dQmU6bLvl6P5d+DLar0Sw2Dsq3q/ylCWAUVI=;
 b=xRgrqeJi5H///Q3A+aHODTXiLcQ3rGltzxYsaDgunoH6T5XbVouniqZjHrDywFIp22
 5Yzp1U2Bsy4PqbXI3kfGLN/bDLDpqBZDYZxWHFdF6SzVaUn4cKIXweRwek4bf3eN/r+i
 pL/P3/OuzGCWoWJqXPeTLjPWBDErcF4uPY6TbHHIByj0GlWx5NRvuK+xGTm8tXAA6h9g
 NAOCGc/4C0lGlBQOnJlYvczx2wX2cJoAgThRFoJuUUcsMVM+b5rgRiGTHVKAsdtfK7V2
 K4w/RZ7XgG8WejFNFURfAuFz4YWyS/aRDP7UyEsYArpFK0yD1shQu9uKKpTokeBB433d
 cnqg==
X-Gm-Message-State: AOAM530ieaclcAfoHCj0tKvzHEiYhH2mZ7opLzOqAJadg8qf/qeq8Pov
 7RmTD358f1IkSaX0ufyE4aiKLpTDMG2aiqqhj89MLg==
X-Google-Smtp-Source: ABdhPJztRVRW3/QmckVYl4Qyku7NmhVkrLWgQRHozwyB7+hutqJ0fbJjiOdFJW0pTwJfle0znxSG5gl3KIkHsykSZyo=
X-Received: by 2002:a05:6102:3c3:: with SMTP id
 n3mr3785865vsq.19.1632813454116; 
 Tue, 28 Sep 2021 00:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
 <20210922072326.3538-1-huangjianan@oppo.com>
 <e42a183f-274c-425f-2012-3ff0003e1fcb@139.com>
 <919e929d-6af7-b729-9fd2-954cd1e52999@oppo.com>
 <314324e7-02d7-dc43-b270-fb8117953549@139.com>
 <CAJfpegs_T5BQ+e79T=1fqTScjfaOyAftykmzK6=hdS=WhVvWsg@mail.gmail.com>
 <YVGRMoRTH4oJpxWZ@miu.piliscsaba.redhat.com>
 <97977a2c-28d5-1324-fb1e-3e23ab4b1340@oppo.com>
In-Reply-To: <97977a2c-28d5-1324-fb1e-3e23ab4b1340@oppo.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Sep 2021 09:17:23 +0200
Message-ID: <CAJfpegsim-qtM4yaYdWo9P+QOP4UD_NrFTKADQky-HwOR=SPyQ@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: fix null pointer when
 filesystemdoesn'tsupportdirect IO
To: Huang Jianan <huangjianan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org,
 overlayfs <linux-unionfs@vger.kernel.org>,
 Chengguang Xu <cgxu519@mykernel.net>, yh@oppo.com, guanyuwei@oppo.com,
 linux-fsdevel@vger.kernel.org, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, Chengguang Xu <cgxu519@139.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 28 Sept 2021 at 09:01, Huang Jianan <huangjianan@oppo.com> wrote:
>
> =E5=9C=A8 2021/9/27 17:38, Miklos Szeredi =E5=86=99=E9=81=93:
> > On Wed, Sep 22, 2021 at 04:00:47PM +0200, Miklos Szeredi wrote:
> >
> >> First let's fix the oops: ovl_read_iter()/ovl_write_iter() must check
> >> real file's ->direct_IO if IOCB_DIRECT is set in iocb->ki_flags and
> >> return -EINVAL if not.
> > And here's that fix.  Please test.
>
> This patch can fix the oops.
>
> Tested-by: Huang Jianan <huangjianan@oppo.com>

Thanks for testing!

Miklos
