Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64353F2D1A
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 15:26:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Grj8T46LTz3cLP
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 23:26:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=eZvf+wQC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e;
 helo=mail-pj1-x102e.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=eZvf+wQC; dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grj8M2jkGz2yMD
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 23:26:26 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so13819097pjr.1
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:date:mime-version:user-agent:subject:to:references:from
 :in-reply-to; bh=V4Il9Yv8lFCwlRC4mJbH/yTuqyP0sFtbFzmRQpPArzA=;
 b=eZvf+wQCS/HyeMWp9plk2fxPndsgVZLvfIwy6pEfrsHpvBKX5ev1Nbrt+dtpP7ZJAU
 Qt+J7cxlTDQcdGGwaq9SXo5+QMjJqPfbxwtpwIQn7AaTJU0VvWuxasEH+T/yEStBYn9r
 lSkH2OtMRBYYRHMF9AArOe7FWDMLRhGdMYX2b95ypXoAhh55RRTQnkiYTCEufs6MEkVu
 apw76fRtbrE/0jcxsM/alifUWbltCLhlUkROUpD9lTZ0/bjcgMWlXBVRdaaU2uYdA1kT
 lx05SaV7N5Fr7DOtpbVnMh0MZmNOvzN0NTJp2brJYvGOztmJ59WGnPozz124mLwQZCOp
 JQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:references:from:in-reply-to;
 bh=V4Il9Yv8lFCwlRC4mJbH/yTuqyP0sFtbFzmRQpPArzA=;
 b=UBqLhPV96zduGONTGPybRHPz9SO5FX/FPzU3xza7pUt0czJAuJ/Pcj2vzJT+6WD+yM
 dYcvktBLpf4+BHSp7D7t1rZAztFiqjCmnMAla0Fwk05f7omfwhRshB8qmXuQJyT09Ef0
 DjSWNCK3isZ7AhrFaMM3yR04FNKRyvlt0geRk+llCP9NPbYbgy9izr9HskJwe6ooE3cK
 uGHSlWoXbeyyayyXpY379u/OUJtqASDWKjc5WaV1jG6GNVGCx//kxiMP0p5CKGfJ1jAY
 DooXUG0mlxCR7IEUk9yD8ep0NKvJzVK6QyfV7webdO4Ld7D02TB7Y3LahlHYbp5imDu2
 jjAw==
X-Gm-Message-State: AOAM532vL6tGzr8MSTL2RJVWQSE4RGAOpiEWBKzTmyqAS0Uxa+EnoxuO
 DChKBcLoLzxobZ2UTzEZGHPbwR0Ri412gSl6
X-Google-Smtp-Source: ABdhPJy1qWOXnFi0qSrvs4PKXjWJpO8p6aSBux2RYlbrD6M/EAHu7dT8CVhf0bNUMuoudqMI3O23gQ==
X-Received: by 2002:a17:902:9b87:b029:12c:c3ed:8a1d with SMTP id
 y7-20020a1709029b87b029012cc3ed8a1dmr16306050plp.7.1629465983627; 
 Fri, 20 Aug 2021 06:26:23 -0700 (PDT)
Received: from [0.0.0.0] (li1080-207.members.linode.com. [45.33.61.207])
 by smtp.gmail.com with UTF8SMTPSA id o2sm1496718pgu.76.2021.08.20.06.26.20
 for <linux-erofs@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 06:26:22 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------f3oq9T68YxlMVS395e8wEHLQ"
Message-ID: <58a28af5-5bca-57c6-3d2a-db18a59f7daa@gmail.com>
Date: Fri, 20 Aug 2021 21:26:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: An issue with erofsfuse
To: linux-erofs@lists.ozlabs.org
References: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
 <20210820124831.GA25021@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------f3oq9T68YxlMVS395e8wEHLQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2021/8/20 21:16, Igor Eisberg wrote:
> You're quicker than expected, thanks for answering.
> Not sure how to check if lz4 was builtin, but considering that 
> erofsfuse is only about 34.5KB (stripped) I would guess not?
> Here's the output of erofsfuse -d (it prints this but never exists 
> back to shell unless I do Ctrl+C):
>
You can use lz4 --version to check the version of lz4 library, I have 
got the same error on the old version, better to use the version above 
1.9.2.

If the problem still exists, you can use the -d --dbglevel=9 option, and 
then perform a read to get the detailed log.

Thanks,

Jianan

>         erofsfuse 1.3
>
>         disk: product.img
>
>         mountpoint: product-mnt
>
>         dbglevel: 7
>
>         FUSE library version: 2.9.9
>
>         nullpath_ok: 0
>
>         nopath: 0
>
>         utime_omit_ok: 0
>
>         unique: 1, opcode: INIT (26), nodeid: 0, insize: 56, pid: 0
>
>         INIT: 7.27
>
>         flags=0x003ffffb
>
>         max_readahead=0x00020000
>
>         EROFS: erofsfuse_init() Line[23] Using FUSE protocol 7.27
>
>            INIT: 7.19
>
>            flags=0x00000011
>
>          max_readahead=0x00020000
>
>            max_write=0x00020000
>
>            max_background=0
>
>          congestion_threshold=0
>
>            unique: 1, success, outsize: 40
>
>
> On Fri, 20 Aug 2021 at 15:49, Gao Xiang <xiang@kernel.org> wrote:
>
>     Hi Igor,
>
>     On Fri, Aug 20, 2021 at 03:34:05PM +0300, Igor Eisberg wrote:
>     > Hey there, getting straight to the point.
>     > Our team is using Debian 10, in which erofs mounting is not
>     supported and
>     > we have no option of updating the kernel, nor do we have sudo
>     permissions
>     > on this server.
>     >
>     > Our only choice is to use erofsfuse to mount an Android image
>     (compression
>     > was used on that image), for the sole purpose of extracting its
>     contents to
>     > another folder for processing.
>     > Tried on Debian 10, pop_OS! and even the latest Kubuntu (where
>     native
>     > mounting is supported), but on all of them I could not copy
>     files which are
>     > compressed from the mounted image to another location (ext4 file
>     system).
>     >
>     > The error I'm getting is: "Operation not supported (95)"
>     >
>
>     Thanks for your feedback.
>
>     Could you check if lz4 was built-in when building erofsfuse? I guess
>     that is the reason (lack of lz4 support builtin).
>
>     If not, could you add -d to erofsfuse when starting up?
>
>     Thanks,
>     Gao Xiang
>
>     > Notes:
>     > * Only extremely small (< 1 KB) files which are stored
>     uncompressed are
>     > copied successfully.
>     > * Copying works perfectly when mounting the image with "sudo
>     mount" on the
>     > latest Kubuntu, so it has to be something with erofsfuse.
>     >
>     > Anything you can do to help resolve this?
>     >
>     > Best,
>     > Igor.
>
--------------f3oq9T68YxlMVS395e8wEHLQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    On 2021/8/20 21:16, Igor Eisberg wrote:<br>
    <blockquote type="cite"
cite="mid:CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">You're quicker than expected, thanks for
          answering.
          <div>Not sure how to check if lz4 was builtin, but considering
            that erofsfuse is only about 34.5KB (stripped) I would guess
            not?</div>
          <div>Here's the output of erofsfuse -d (it prints this but
            never exists back to shell unless I do Ctrl+C):</div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>You can use lz4 --version to check the version of lz4 library, I
      have got the same error on the old version, better to use the
      version above 1.9.2.</p>
    <p>If the problem still exists, you can use the -d --dbglevel=9
      option, and then perform a read to get the detailed log.<br>
    </p>
    <p>Thanks,</p>
    <p>Jianan</p>
    <blockquote type="cite"
cite="mid:CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com">
      <div dir="ltr">
        <div dir="ltr">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">erofsfuse 1.3</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">disk: product.img</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">mountpoint: product-mnt</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">dbglevel: 7</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">FUSE library version:
              2.9.9</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">nullpath_ok: 0</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">nopath: 0</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">utime_omit_ok: 0</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">unique: 1, opcode: INIT
              (26), nodeid: 0, insize: 56, pid: 0</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">INIT: 7.27</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">flags=0x003ffffb</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">max_readahead=0x00020000</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">EROFS: erofsfuse_init()
              Line[23] Using FUSE protocol 7.27</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">   INIT: 7.19</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">   flags=0x00000011</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex"> 
               max_readahead=0x00020000</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">   max_write=0x00020000</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">   max_background=0</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex"> 
               congestion_threshold=0</blockquote>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">   unique: 1, success,
              outsize: 40</blockquote>
          </blockquote>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri, 20 Aug 2021 at 15:49,
          Gao Xiang &lt;<a href="mailto:xiang@kernel.org"
            moz-do-not-send="true" class="moz-txt-link-freetext">xiang@kernel.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi
          Igor,<br>
          <br>
          On Fri, Aug 20, 2021 at 03:34:05PM +0300, Igor Eisberg wrote:<br>
          &gt; Hey there, getting straight to the point.<br>
          &gt; Our team is using Debian 10, in which erofs mounting is
          not supported and<br>
          &gt; we have no option of updating the kernel, nor do we have
          sudo permissions<br>
          &gt; on this server.<br>
          &gt; <br>
          &gt; Our only choice is to use erofsfuse to mount an Android
          image (compression<br>
          &gt; was used on that image), for the sole purpose of
          extracting its contents to<br>
          &gt; another folder for processing.<br>
          &gt; Tried on Debian 10, pop_OS! and even the latest Kubuntu
          (where native<br>
          &gt; mounting is supported), but on all of them I could not
          copy files which are<br>
          &gt; compressed from the mounted image to another location
          (ext4 file system).<br>
          &gt; <br>
          &gt; The error I'm getting is: "Operation not supported (95)"<br>
          &gt; <br>
          <br>
          Thanks for your feedback.<br>
          <br>
          Could you check if lz4 was built-in when building erofsfuse? I
          guess<br>
          that is the reason (lack of lz4 support builtin).<br>
          <br>
          If not, could you add -d to erofsfuse when starting up?<br>
          <br>
          Thanks,<br>
          Gao Xiang<br>
          <br>
          &gt; Notes:<br>
          &gt; * Only extremely small (&lt; 1 KB) files which are stored
          uncompressed are<br>
          &gt; copied successfully.<br>
          &gt; * Copying works perfectly when mounting the image with
          "sudo mount" on the<br>
          &gt; latest Kubuntu, so it has to be something with erofsfuse.<br>
          &gt; <br>
          &gt; Anything you can do to help resolve this?<br>
          &gt; <br>
          &gt; Best,<br>
          &gt; Igor.<br>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>
--------------f3oq9T68YxlMVS395e8wEHLQ--

