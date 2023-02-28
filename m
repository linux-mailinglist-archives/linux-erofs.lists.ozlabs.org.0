Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEEF6A52B7
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 06:51:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PQmhD5Ddcz3bT0
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 16:51:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1677563484;
	bh=KVO9D3it9baXxwOs3sdGaxeINko9L5QuRxlEmbnRx9I=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BUsoALyyAfu3h1MX0dUXo0rH71CbyKYAUy/x+BQgbMKjGDZX2m/MvraUekvbSBQTt
	 PNPCSY/oTwXQZ1EjGJYy6etYYt5jo8eIBJhsbeaD3mDsv75uOo8zVuS1KDVFFshcrq
	 fV4MC8iEnLao3Uh7nn+i07hZMey1INZDmU9tDjaDXTLdnHVCdImqaWR7gsnMgvLhjT
	 Zg0mEyXj2ELom/cEI8U8/iVfKlL2j1PaEB/BrWL0fNT+WbznmArW1I0SwtujVQ016z
	 nmL9eKJjp2Wr4e06U55i9o3kzCSoxq3WFtpLEwZtidnvG5FfStaBVQpK+5c2jeRj4X
	 D5wBJ/ZMfrYpg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=dhavale@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=jPOIf+aD;
	dkim-atps=neutral
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PQmh90tqSz2ynf
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Feb 2023 16:51:19 +1100 (AEDT)
Received: by mail-ot1-x335.google.com with SMTP id c2-20020a9d6842000000b0068bc93e7e34so4954053oto.4
        for <linux-erofs@lists.ozlabs.org>; Mon, 27 Feb 2023 21:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677563476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVO9D3it9baXxwOs3sdGaxeINko9L5QuRxlEmbnRx9I=;
        b=qfQHdKtKu6QS4n6hU6Rhyp9o+9GOfIBPnuIcljPBRtlsqwZERrelhdYCD7L95q4LFs
         gA7LA3T/iIH7K4sMGg8OwRsoBLHqraRl9TdYXfgjqPH48dpE3PjhIs86skyzYqyxYboL
         p9/saBOwYKY9KwEYSQ3YYAMqn+A1+IgOulvN8YhMrG53iO6WntKk1JIhV8cV9HG29nfG
         7L2NCO70ZdlhhXyubLm7nZ8ST61Ft++er8wsyXC++5Sajh/l3RRrx8ECvv8VA6V8WPOo
         SxvmtmDESM/n3EXZlfdczT0X1zeZJX7zEygf1fZJoBsvarGwdFJ95Cm9LuLc8CXjH7Hq
         wMLQ==
X-Gm-Message-State: AO0yUKXattNHFPJFK33CP7bNjVNZzmE4Bq92Bjq08eEhsry5tFO53tkK
	HFzX/m1fi3pKtgDp594WORXw5S0rUOnkP+12CmeSgg==
X-Google-Smtp-Source: AK7set8xPfpIn1P5Zdq04cHzmCCh/Wgn+RuC1dRItO5lpXetxNt5SGHlyR3GxK/vU+AEmzlQZeJGZGBTkEslWnFfFpo=
X-Received: by 2002:a9d:315:0:b0:690:ed96:e019 with SMTP id
 21-20020a9d0315000000b00690ed96e019mr562300otv.4.1677563476282; Mon, 27 Feb
 2023 21:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com> <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
 <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com> <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
 <CAB=BE-Svf7TMPs-eA+sVuGtYjVWfKd1Nd_AkA9im4Op7TCLW3g@mail.gmail.com> <1f926a20-6b45-137d-4e78-30025ba33574@linux.alibaba.com>
In-Reply-To: <1f926a20-6b45-137d-4e78-30025ba33574@linux.alibaba.com>
Date: Mon, 27 Feb 2023 21:51:05 -0800
Message-ID: <CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com>
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an option
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Nathan Huckleberry <nhuck@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 27, 2023 at 9:01=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Sandeep,
>
> On 2023/2/28 12:47, Sandeep Dhavale via Linux-erofs wrote:
> > Hi all,
> > I completed the tests and the results are consistent with
> > our previous observation. We can see that removing WQ_UNBOUND
> > helps but the scheduling latency by using high priority per cpu
> > kthreads is even lower. Below is the table.
> >
> > |---------------------+-------+-------+------+-------|
> > | Table               | avg   | med   | min  | max   |
> > |---------------------+-------+-------+------+-------|
> > | Default erofs       | 19323 | 19758 | 3986 | 35051 |
> > |---------------------+-------+-------+------+-------|
> > | !WQ_UNBOUND         | 11202 | 10798 | 3493 | 19822 |
> > |---------------------+-------+-------+------+-------|
> > | hipri pcpu kthreads | 7182  | 7017  | 2463 | 12300 |
> > |---------------------+-------+-------+------+-------|
>
> May I ask did it test with different setup since the test results
> in the original commit message are:
>
Hi Gao,
Yes I did the test on the different (older) hardware than my original testi=
ng
(but the same one Nathan had used) to remove that as a variable.

Thanks,
Sandeep.

> +-------------------------+-----------+----------------+---------+
> |                         | workqueue | kthread_worker |  diff   |
> +-------------------------+-----------+----------------+---------+
> | Average (us)            |     15253 |           2914 | -80.89% |
> | Median (us)             |     14001 |           2912 | -79.20% |
> | Minimum (us)            |      3117 |           1027 | -67.05% |
> | Maximum (us)            |     30170 |           3805 | -87.39% |
> | Standard deviation (us) |      7166 |            359 |         |
> +-------------------------+-----------+----------------+---------+
>
> Otherwise it looks good to me for now, hopefully helpful to Android
> users.
>
> Thanks,
> Gao Xiang
>
> >
> >
> > Thanks,
> > Sandeep.
