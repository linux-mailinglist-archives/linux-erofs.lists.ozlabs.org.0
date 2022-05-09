Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F6451F2C6
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 05:06:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KxQzl3msyz3by0
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 13:06:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=6xJ96j3c;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bytedance.com (client-ip=2a00:1450:4864:20::12a;
 helo=mail-lf1-x12a.google.com; envelope-from=yinxin.x@bytedance.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=bytedance-com.20210112.gappssmtp.com
 header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=6xJ96j3c; dkim-atps=neutral
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KxQzf1BrGz2xnT
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 May 2022 13:06:03 +1000 (AEST)
Received: by mail-lf1-x12a.google.com with SMTP id bq30so21565432lfb.3
 for <linux-erofs@lists.ozlabs.org>; Sun, 08 May 2022 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZPCLl0WNrEQ8X7TZbGk9F5F3Xw31TIAi53cscMQsEGE=;
 b=6xJ96j3c30HoyM2X0hOy9P1hGJLuH0A96qdPaznCYucEVe+8Xjgjzl3k4EkeeiMsJR
 k1bhgngPuoX8XuhqFShJQsQz+g1JmAAB6xf2xZzUwZwZnDoPfJdfEbBFttzjIVk1FdSK
 MIW9Ospi1Tz9i3tuZxlNEOl6D52+nCsQ33Gm9u3S4X57eBETIq0sXb6ZRNrDZWt9Zmco
 xiyJyXaRHhXHIa2rRHeotUBAHkx8rajzRRXFjMcyAeqxkvVmkYhOu04r7r49U0WOh41a
 CUEoJESUx7KT8KrEDnZRRMAv3vf0tuo9a8nLA+BGGuXdQMG/SOXC3luvwLcyhmCB2f0k
 Z4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZPCLl0WNrEQ8X7TZbGk9F5F3Xw31TIAi53cscMQsEGE=;
 b=Txg4DIkYkge7sq7fpLD1zI6aPEoQFxYKOmkwM73k67eWXBJeb7d09oa4RAFD3dLhBQ
 QJfQ0qFBQQiWMiSVQ2qep+FvgYmkHgNu5b/sC9/whVnBUEDpJAeEIJeJlmP4NDfN8Gv7
 zUvs7HL7o4pG142lSihhOGkjyqXx6IoG/2PSJ+pQlz1VS7YmkvHDvwChV5bucjLk3mBx
 QPKciqLllwOLuEOWkbHYojVpRAXcLD7JVL3O5zF6lCs2koJF2gMpIdldHB170qf0v4nY
 Xb3cRXTgnX4TN9TgkgF63gdLUXdkRAAEL65ixz7K/fefQ3RE4yeOz/TSKRH+2U6yJSCR
 vFBw==
X-Gm-Message-State: AOAM532Th6GLlDMgRCqHmjOrhmzWw5sAJsR9cXqKmiWHBycV7CLIUDcK
 Uvusbis1hCU/DUlcRl4zokARLV/jV1lp1uc5l7xD8Q==
X-Google-Smtp-Source: ABdhPJylEsq2ZJj98ROOaWvCI5t7ScvLOENldeObjFe7fZFxjD/+x6tUKQL2zAuBGgq3+2z6PXGp7OAUYFJuce5ib0g=
X-Received: by 2002:a05:6512:13a3:b0:474:2642:d00e with SMTP id
 p35-20020a05651213a300b004742642d00emr2476580lfa.328.1652065558196; Sun, 08
 May 2022 20:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220507083154.18226-1-yinxin.x@bytedance.com>
 <dfcbda24-3969-f374-b209-81c3818246c1@linux.alibaba.com>
In-Reply-To: <dfcbda24-3969-f374-b209-81c3818246c1@linux.alibaba.com>
From: Xin Yin <yinxin.x@bytedance.com>
Date: Mon, 9 May 2022 11:05:47 +0800
Message-ID: <CAK896s68f5Snrip8TYPfDbObOpNoTtWW+0WBXzTiJbadAShGrg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] erofs: change to use asyncronous io for
 fscache readpage/readahead
To: JeffleXu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: dhowells@redhat.com, hsiangkao@linux.alibaba.com, linux-cachefs@redhat.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, May 7, 2022 at 9:08 PM JeffleXu <jefflexu@linux.alibaba.com> wrote:
>
>
>
> On 5/7/22 4:31 PM, Xin Yin wrote:
> > Use asyncronous io to read data from fscache may greatly improve IO
> > bandwidth for sequential buffer read scenario.
> >
> > Change erofs_fscache_read_folios to erofs_fscache_read_folios_async,
> > and read data from fscache asyncronously. Make .readpage()/.readahead()
> > to use this new helper.
> >
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
>
> s/asyncronous/asynchronous/
> s/asyncronously/asynchronously/
>
Thanks for pointing this out , I will fix it.

> BTW, "convert to asynchronous readahead" may be more concise?
>
You mean the title of this patch?  But, actually we also change to use
this asynchronous io helper for .readpage() now , so I think we need
to point this in the title. right ?

Thanks,
Xin Yin
> Apart from that, LGTM
>
> Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>
>
> --
> Thanks,
> Jeffle
