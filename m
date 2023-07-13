Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11E751620
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 04:16:59 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=hkYYZxV/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1dXT0LZyz3by2
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 12:16:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=hkYYZxV/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=joelfernandes.org (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=joel@joelfernandes.org; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1dXP0t2rz3bm2
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 12:16:51 +1000 (AEST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4009ea1597bso2129461cf.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 19:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689214607; x=1691806607;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLRUl5AEz4xfBRj0i8SQThC0f/OuUsY40TC9Xg4abaA=;
        b=hkYYZxV/H6WPwxqD8d9vTMIlQVEbUwmHDwP456khtAclR9f++sJEJVcmMm6doJpAaQ
         ogqF5NtL1hNnF/kt+Sxly7CdccRu+h9u+yM79dJXBa0/Judo/EX7b42d6IVleLt5scnY
         FhIej7EBkK0LF8qZ58Pz9eSUj8zfP82glH7zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689214607; x=1691806607;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLRUl5AEz4xfBRj0i8SQThC0f/OuUsY40TC9Xg4abaA=;
        b=KnO5ovO9Uix8W3urH7SJK+ROeC0a4nbcUsKOH2mHtGD2GgOEGLVAFZogccMz9M2ViE
         L37I4Tz0Y4f9TpI1U9olZKzLqwBUPajVlsMq+op6Qp/8z2tlBtw8RVWqD1w4YNc0yxZ6
         bglimbQl2rJZooSOuTYuLwseSJyihB2zlJhtfREG5HOCQojmith9kHOyXtI96Rxvr75g
         oseBW7U/6fTZqLL27qZgNrsbmrPnHYghdRixs1hzQD8N8/sEMaU2F0b6bTA373e4Culk
         5925TKAbPjc0QKhSoOxyxzhXtpAkSboigjru+wYoeWmUBK/qZNZX2Ime01aJVCRu9y6n
         zJ3Q==
X-Gm-Message-State: ABy/qLZQNmZ7JPVoUPVTCMn29uJjoyECOyfOh6HfQzX9EwZD+JN9dRC/
	mgZptWN9YdCxs4M3lq6/8Gti7g==
X-Google-Smtp-Source: APBJJlEHYFXDl9ioZHBQvN/8vyjr4+5VOyHSJ2h1343YSyKCNTY2VRSulWSAIsk6+5Jj5IBsNS3DvA==
X-Received: by 2002:ac8:7d4c:0:b0:401:e1e7:a2a4 with SMTP id h12-20020ac87d4c000000b00401e1e7a2a4mr404180qtb.35.1689214607496;
        Wed, 12 Jul 2023 19:16:47 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.85])
        by smtp.gmail.com with ESMTPSA id t4-20020ac85304000000b00401f7f23ab6sm2713019qtn.85.2023.07.12.19.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 19:16:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
Date: Wed, 12 Jul 2023 22:16:34 -0400
Message-Id: <5DA6D217-8847-4760-9C23-CB1B26B5CC2B@joelfernandes.org>
References: <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
In-Reply-To: <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: iPhone Mail (20B101)
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
Cc: kernel-team@android.com, "Paul E. McKenney" <paulmck@kernel.org>, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Frederic Weisbecker <frederic@kernel.org>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



> On Jul 12, 2023, at 10:02 PM, Gao Xiang <hsiangkao@linux.alibaba.com> wrot=
e:
>=20
> =EF=BB=BF
>=20
>> On 2023/7/13 08:32, Joel Fernandes wrote:
>> On Wed, Jul 12, 2023 at 02:20:56PM -0700, Sandeep Dhavale wrote:
>> [..]
>>>> As such this patch looks correct to me, one thing I noticed is that
>>>> you can check rcu_is_watching() like the lockdep-enabled code does.
>>>> That will tell you also if a reader-section is possible because in
>>>> extended-quiescent-states, RCU readers should be non-existent or
>>>> that's a bug.
>>>>=20
>>> Please correct me if I am wrong, reading from the comment in
>>> kernel/rcu/update.c rcu_read_lock_held_common()
>>> ..
>>>   * The reason for this is that RCU ignores CPUs that are
>>>  * in such a section, considering these as in extended quiescent state,
>>>  * so such a CPU is effectively never in an RCU read-side critical secti=
on
>>>  * regardless of what RCU primitives it invokes.
>>>=20
>>> It seems rcu will treat this as lock not held rather than a fact that
>>> lock is not held. Is my understanding correct?
>> If RCU treats it as a lock not held, that is a fact for RCU ;-). Maybe yo=
u
>> mean it is not a fact for erofs?
>=20
> I'm not sure if I get what you mean, EROFS doesn't take any RCU read lock

We are discussing the case 3 you mentioned below.

> here:
>=20
> z_erofs_decompressqueue_endio() is actually a "bio->bi_end_io", previously=

> which can be called under two scenarios:
>=20
> 1) under softirq context, which is actually part of device I/O compleltion=
;
>=20
> 2) under threaded context, like what dm-verity or likewise calls.
>=20
> But EROFS needs to decompress in a threaded context anyway, so we trigger
> a workqueue to resolve the case 1).
>=20
>=20
> Recently, someone reported there could be some case 3) [I think it was
> introduced recently but I have no time to dig into it]:
>=20
> case 3: under RCU read lock context, which is shown by this:
> https://lore.kernel.org/r/4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.aliba=
ba.com/T/#u
>=20
> and such RCU read lock is taken in __blk_mq_run_dispatch_ops().
>=20
> But as the commit shown, we only need to trigger a workqueue for case 1)
> and 3) due to performance reasons.
>=20
> Hopefully I show it more clear.

Makes sense. Thanks,

 - Joel

>=20
> Thanks,
> Gao Xiang
