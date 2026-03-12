Return-Path: <linux-erofs+bounces-2680-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC4ODAS+smmvPAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2680-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Mar 2026 14:22:12 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B367F272702
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Mar 2026 14:22:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWpDv64nXz3cFm;
	Fri, 13 Mar 2026 00:22:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773321727;
	cv=pass; b=X1Zd+y3kOOXPI1xBagI2bclIIS2gAaWvXusW5hPmr9nKy+507aH/iIHv7575fwkdGd2GnAPAXcO8RNYxlyzH8315+U1V64IZ9RmlUt/p+TkIJUZKJcMsta8ppjRTfH4AUv39v+1Jw+zl65oHEV2Z1D4gvmy55r9CjwYOUMu6VdmKK1ozdbfVL54s9CKS4padQr51txZx5/0KgJGjW8/4lahDilMDtGGQiWL4pNpkbzw3ZK5YbYrdvHVNqMFtxIgNCNXf/cP8IieJO2Tba8xFPFCR8mbOu7MDtV7bu4iUdQXiq3CfyKC5ui3csnKFIf8IQP+26ROxTorng4Meqx2BJg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773321727; c=relaxed/relaxed;
	bh=sb8hO7chImj3rHjxxBE5wvRJXcNQuQQJPXbpLdARXf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aN9qeHbuy5o+HZwCFEVOpavj7R9eauRMsgi+q4mV6f21rMtvSg6LzsyLNT6U/W9jIIGVmb9SGfyTqRHBemWtxRoWNkAjIuDQ3SL3zxD6O+pR3Kz5wwlac5Z2zApuE7oF+SLZfj3eT/lT/XZXrub5l6b1QO17zYCBkSmkgT6olDChZDtWJ6Jn7/2LUhnzGGxpmSV3VooHpfMf/WfkCDts4Ji4Gcs8cjBaFk4t+H4e7jANuqVbpN/8KVvFSMcu0zbTmWIsYhA4pRmOUeDhgIxmDMGj7TCXQt1NnOP2P5cLnS0oLqbPmj8A2qofIK0D7pzVDNzr+G792PNDkqKjKJdHTQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UKF76mxC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UKF76mxC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com [IPv6:2607:f8b0:4864:20::b134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWpDt20cTz3cFN
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Mar 2026 00:22:05 +1100 (AEDT)
Received: by mail-yx1-xb134.google.com with SMTP id 956f58d0204a3-64ca1ba0089so968630d50.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 12 Mar 2026 06:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773321722; cv=none;
        d=google.com; s=arc-20240605;
        b=OibKbJJyaZkmULBQ10Fe1ZIRPgZYz1QdAzISjjOVvQKuw1KCkSz4SLHS+66WAnXFYu
         lHzgumxu4wsTqBJ90Yzyl4sMqA+tZ49BAVgCGd18Y9s69sskrmVrGT0/fGtzMM21K4YH
         vrGO/c0B8R6VDqCkYIK4fFbWAvnixcAiTIhRntiUbB0+gevI7tIrcnyoYEt7iw8slVm/
         sOy/LftuhbCQleZypR/gdPw1Xe9AQ7R3Es3xJy8Dx4chJjyPYQ0dS+e2b2+9XgFNbv1a
         Y//gy7tz4kiXPXpvMAL0PkCzHIvLc03LT+oUPkZJFxgPFE6mewQiD9aV8dPITRm4SIaI
         8xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sb8hO7chImj3rHjxxBE5wvRJXcNQuQQJPXbpLdARXf0=;
        fh=PJFfRQvK4xp1bCuSdEhaXC1JZVyef3x+vt2XZ4bIntc=;
        b=J0TMBoqp6nI+ufysq9ltt/iMV0hT0pdUe+QW4D30wmIHK25BzhbHPadxR6P2nvWbL9
         GOPH1+6CNtag4r+KCXteO/sht1BJV1dc8Q12UsVhZlqlfqF4rS1MqkPLrL9OWd51Q2S7
         dGgBy9FSSN0J1NmJcu+uTDhWr5r90ACen391afxFqAUjf8/Ke+vae2MRn8+IKhrOjjqC
         XKXj46ZTK50Lw4s30Sfx2VU2uXh8e5Xz7eJxAplW1jHbCSE8ghnivo+uitQGT2GwJ9ud
         baGHV5Y0QlSHSL6V1CgLQl80OwA8eg8a92HG3dvHzpsNn0ej971by0/6PTND03g2ex3E
         rj6Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773321722; x=1773926522; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb8hO7chImj3rHjxxBE5wvRJXcNQuQQJPXbpLdARXf0=;
        b=UKF76mxCWYjAgCjxcE5ON6x1fwQ/rsk77VNE5Tw0yMAQ4CY3dtZUYx5lwbZslcSoRI
         gwgELbaVXPu7mmSi3WhyvPIJNXDN2RoMMlt8vAvGU7UvqdyDbEK1NoOM8N0tvgsUPlon
         gDMu+SaCpCX3g7YS1956ysM5xGaPqp+i0ojfPbqVcvwjGBy4KmzU+UG9o+A+8ay0iRiW
         0JKK5KzoTlHr5Y/LyRPbKVtEMIsgflXcV/4HejmyqPbH6YZYgBFSXBWGAvdm+98sVCTd
         G31/jImiw9wu9FSe/VPQAjeC242GPxQPUVL2KeDqxZMkhHBe4hlAdMm9z3YGQn7bgjIX
         mFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773321722; x=1773926522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sb8hO7chImj3rHjxxBE5wvRJXcNQuQQJPXbpLdARXf0=;
        b=SZkifEE1qbFB97RuAPf2pNpgbjMGDlBkoapn3VSouB7KLNIrkQ516JKhdjIlLiCNIs
         ShPoICce5+Rbyxh2cZW7okbXbluf16CFYv14G8bHruOZeNz+K/kebTQBkfGOAEV96Phu
         IBnNv3Zcn2lgCIy8eKQOFqia8NK65bkDheEbt7s590ebCX7EVMrWMGOyU7uDZELzyM5E
         Fxx7I+08AgdJvH5pSXGnzzyzjnQMZcC0LG5ekWZVAG3CWcMvhuasTY/inkj+MDI8Sl6A
         Gfg+Ki4VvFkoJmJZ0ospHGJYj5tnlbp1wLKkknYjia9vRL3X4kal4v8b8cSrklJJTi6R
         CPwg==
X-Forwarded-Encrypted: i=1; AJvYcCWGp03qAtIg9nbG8fcV+VRKWVKYt20hVXefx0NzhchoH6je/YvCWqQQ6NmfWo86YpCwEnaKZsgnivQV4w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqAI0niNnP21hJEDuWs3HFSdx6T6ZEMBcMlmtRbAqGCT1aBAGt
	tJIRAzZ72UpfaVsxsGpbYIS/YVCn2h1Mh6oUZ9RghOkkJJ9K7+eIZJl5zbqP56Gp/UrD47ZnKoX
	b85Yo0WRZLbsgSU88aa5jseUKDd/OkIs=
X-Gm-Gg: ATEYQzw8zNIAY9s3I9xL1FGZPSmu8tcc6nTwCENnI9Rgy2Nzm4ddgHB9DVxb2ATeOmm
	Aeg3DLdanehmrd8tu1Ta6z0mK3Ld+YbKUUqfTFqAoUz6hBcV9y77yY874SsfPvHVGWXezj10Gcn
	JRViBWkFcIdAoD/XNjU9JFS6I2eEgAP3CZS+c4D4Xiy01+phwHn9YU35WxJ6+Bt6PYE1MUCTh35
	oVzrQwkOoo49IRqrvzr7osFudhqGRMr6DSo7IsL9lxOoKTd5i4og6iHuLC+76gnKgPTtLZxLdbf
	NOVuD7zZjbOQhcfcUg==
X-Received: by 2002:a05:690e:c41:b0:63f:b5d8:9db3 with SMTP id
 956f58d0204a3-64d656d1c71mr5665811d50.8.1773321722436; Thu, 12 Mar 2026
 06:22:02 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260307062810.19862-1-nithurshen.dev@gmail.com>
 <b9387ac5-e717-4e9c-910f-5b218d177e64@huawei.com> <CANRYsKgoA9pMsDnBRnLgpY7ydYcuq8FxEhs+NCw9_p2ABjsMnA@mail.gmail.com>
 <66946454-25ab-4550-84af-53bdecac839d@linux.alibaba.com>
In-Reply-To: <66946454-25ab-4550-84af-53bdecac839d@linux.alibaba.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Thu, 12 Mar 2026 18:51:51 +0530
X-Gm-Features: AaiRm52B2R0gUuw7tiDm3HzWJPzUXU1P-lW563CiNIZ-t0-09AgYiKM3j0mtkhA
Message-ID: <CANRYsKihFHxHdjyhBgX8W+_j-mr+hMNf8M3KG0HmWMODHn87Kw@mail.gmail.com>
Subject: Re: [PATCH] mkfs: support block map for blob devices
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, xiang@kernel.org, 
	Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2680-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhaoyifan28@huawei.com,m:xiang@kernel.org,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,huawei.com:email,alibaba.com:email]
X-Rspamd-Queue-Id: B367F272702
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 5:10=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2026/3/12 17:56, Nithurshen Karthikeyan wrote:
> > Hi Yifan Zhao,
> >
> > On Mon, Mar 9, 2026 at 5:08=E2=80=AFPM zhaoyifan (H) <zhaoyifan28@huawe=
i.com> wrote:
> >> not reset m_deviceid. Could you help also fix this? If you are
> >> interested please also add related
> >>
> >> testcases in erofs/erofsnightly repo.
> >
> > I have opened PR #7 in erofs/erofsnightly repo.
> > https://github.com/erofs/erofsnightly/pull/7
>
> Such test cases should be landed in experimental-tests
> instead rather than integration tests (erofsnightly).
>

I placed it to erofsnightly because, I was specifically told to by Yifan Zh=
ao.
I will send a patch to experimental-tests branch shortly.

> I will check out later, busying in other stuffs.

Sure, you can review it when you have time.

> Thanks,
> Gao Xiang
>
> >
> > Thanks and regards,
> > Nithurshen
> >
>

