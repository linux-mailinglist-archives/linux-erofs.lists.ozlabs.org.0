Return-Path: <linux-erofs+bounces-2870-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFEtM+mlvGlL1wIAu9opvQ
	(envelope-from <linux-erofs+bounces-2870-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 02:42:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E592A2D4D5F
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 02:42:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcQKL4FqNz2xm5;
	Fri, 20 Mar 2026 12:41:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2001:4860:4864:20::2d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773970918;
	cv=pass; b=DisGhMnexMgXWo+YNEfKyau8bDzWQYGKkmbVV2Ce3EHpN4FU5gwQMcFycA8OgJR88bxPwfO1hsNAzeqlKhK/5+FjqjQ4H9TkKoqsl9OZm04Bdu+6jgYIxONDk8+RYrFxYyx8j/vkvyOlest/3nZl7yBlO5eD4AsGydvffmmaAPKA0AKQ0uUVW1uPgJiHeZgAvj5d3LENBzfoP2QetSsFbCelkzP8UuQGr6kztqtIMgIkoYVCggRqt/XyVZRYmm30X5Wi3U6Nt0E9uYcpSpydBWaTT86Gi5cdrMem5bnBCTftkn1IxGo6sBPpoNMBuOI3ot7NiltFSClB/a4mcIGxHg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773970918; c=relaxed/relaxed;
	bh=sR+07rJjrkjsrViOqvewPQ7bCttaCtZ+sUOiCe4RVZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+tZ9IYwbkvOxsRtRBIbSqbOCI36F5fR4xdYJwDbgFDd1u6rWyW3v18kxbpO6reu+YPMlrnUTFpM3uTQuVVAA988C6Ff1lrV0Z5mvfIjLxTjCyHfSqt/7yLQJZRNKo3FV0XbYyMpoQonJewh07SZKCjGzzYjE2IIyy1LOt8jxcjDrtm6IrAAF3amcuOidt9g5rZhLYb7XQ5ojqvQaDLNt24MaKKSnokmGP2hiVGiXtgJ44Tl6qEy/nOcrlry+FI1Xm5zjIL2MIzI4GZQooFr6IatgwwiTnHsIBZa6p9t9uSw0Czl7aLv6iqch/iAjIZIHXHbqDUA2WfiiSUJ61bshQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GvYXnfeX; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com; envelope-from=smsharma3121@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GvYXnfeX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com; envelope-from=smsharma3121@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcQKK24Fcz2xly
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 12:41:57 +1100 (AEDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-41726377fe4so141423fac.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 18:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773970909; cv=none;
        d=google.com; s=arc-20240605;
        b=CGgokDF7oDVFthD8g9esbVxERZZseh5kLdfPFW/Fng/OExthD69TciA3E+1HooE1ae
         s3qbXAs+BULtqLkK/MKlaASxAwe/oPgENk2dZZq1n1yV2iIPo69IAn6FVnMNtOgFKRtY
         cqlto+rn2NtTMwSpZzqc1yw7RO3t7gRYbyNpVfxhrsHfSlE0/nMEHyHsrS4hOjR9sHk4
         WCwj/JdcTCS4DgLFMU7dAWCSo1g82zb6RObJyIJrjY8/+4udOzDGsOzJ5v05WIspvSk9
         /1KLpNVCTlHx8y+JbYDkmTH6zE+ZzcdEtRGXrMaB/vkpC5ezGL5jGgZhVHYdaHrK9TDT
         zXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sR+07rJjrkjsrViOqvewPQ7bCttaCtZ+sUOiCe4RVZo=;
        fh=Nl50vQJ1g2mqJs3lscLnkJaSNLEag4LamBAHUFSrD6U=;
        b=h5jH4dNPSwDSqmuBOJSUN5Xgb9ws8ddmiRPfT6VPF9uN3aGCrzpdgU20TNrj8L6mqU
         hzDdK4da4P17K5708Ddy2FFyjSw2yJg2nqKv7SbmYxBgg3Qpz05T/rFrfVdWmsDVFsUT
         r/K3pqA0D7JEl3AQDdrTS4I+QTT5hGQjrxou13qeAC2EOGt0Zvoc+4iHJXfnFA5mcq0U
         wbLF01SBSR23Kal6Ta0c0tBNExm/4Rnb9tk6YinVtE0EcHdUGlGVg81f4X1OwL+7UNBh
         1eRZVbjg9wWgVmVcQ4ThpeScOj9oL/QPdVFTki1gGq000J+StSBgBKQ0k3dpXlFYqNXX
         QW+Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773970909; x=1774575709; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sR+07rJjrkjsrViOqvewPQ7bCttaCtZ+sUOiCe4RVZo=;
        b=GvYXnfeXu2I3xC1wb9IGhN7Yifvbh7NFBikrNzxZpHytiv7Ag/QEJ1c//dKFw0MvCH
         OA7d+osHPIl6Dc6pTyiBl5p9wMYNY/F6pBOH8gUuJqrOpJQsdDxzlOTPhAMdYN+1LtGJ
         gyLLFZUfZbR5Zo/rXB7CGYgw0BVuprbkbB/gl2L0Pzdsh+k1fnpW2kyJmOkRlHV9luAU
         tfx+hqU3nZgy/IOVjAfP8aUsBTME2lE9UuGtajnL7CXSaL+Bx9tENIcuPKNv/Bl1aTpQ
         hz3gsqp3gDD4S9Nqb65bATwJmuStAVFizmaFfia3fTeBkNJ6GUbSpMOCJoPtqxxrH9la
         hxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773970909; x=1774575709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR+07rJjrkjsrViOqvewPQ7bCttaCtZ+sUOiCe4RVZo=;
        b=NwqdFrfjk3u9ljjWEDdC4ZRdFidy4pKMqscKVxy12kfIhsyCYUihKdedBKQUNvT6p1
         tduSc53xInz2g+M/JAK7PkdYkkHU5L2mcdlU/e1n3+Esq1OggqpjvIr2eqU8pgpY0qn2
         fdgR8KXJoVZemvSvUpOCO5GQx6dkZev09RKF6eRA11D6XmVbRL0zpWSDcUBQ7wHuwNeB
         GZQOMY8VHh4Q0D8BwYD5UYq8R72K3fmi2eDdlKvS/vczcCFQonSyQn+fGuAv4NIDDrg6
         Watn5ATZ2nEZOBljUE5TXq9GWqswFJyLBWawgPcgrRREdM4K7pm0ExPMvVgP8EpB1UDf
         LKfg==
X-Forwarded-Encrypted: i=1; AJvYcCWZs0P++u8GPX+fWPuHOrAeZxVPEhFrSmHADSfsXRWnWfRkM3vbP1JMUVGAMClZWJfrkz8woojVirBUmg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6t560RyIaDJ4yUls3fjxfyaG6HcBecpTbsOD+X/2smr2g4jDG
	6WgKC6aQCmskEcSs0FpAL2tFuupyyUUc0RB/imwdfJovUFBtd0GUW7l8m9CxIWFq4HsAP8hkhmw
	ZyjTzCOsI8l9k5DHQpQcSwBuN5jShD+c=
X-Gm-Gg: ATEYQzxvgJKsn+ApJqklnlOS5nWrZmKckSL3Sx1+rCuXKOZPBJA9zDNV4jcasZIgFgh
	fdXEMJUCb8vHkF4xOXC2CMipGEkQ3IxCCISKxGF2kYxJ92b2/HXHdHYIMpN6JE9itOKBwwqczt5
	9RG+xs8yDhuM6JoujJtbZzeT+6Eh4cK7wv7rAfhXHcjbQcsodVgNZUQ/gdRQmxMkgeAQRLByG7a
	bqb5fXQyS1erxMIOR36T7A8TsWqpQ1dRkQd6DYCMAtNMmLwCBgqI1dhzAErB5utlMk6/azcvBXp
	hnSHnp36xw==
X-Received: by 2002:a05:6870:a112:b0:41b:f7f5:e886 with SMTP id
 586e51a60fabf-41c1124427cmr703657fac.6.1773970909380; Thu, 19 Mar 2026
 18:41:49 -0700 (PDT)
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
References: <20260319221136.2126-1-smsharma3121@gmail.com> <CAMhhD9hbenqz2z2pRQ1EoSNttATsTnW9BZcgFVZ1VPCzAciHiw@mail.gmail.com>
 <0b0ad26c-f462-4274-aaad-6a8e079c0963@linux.alibaba.com>
In-Reply-To: <0b0ad26c-f462-4274-aaad-6a8e079c0963@linux.alibaba.com>
From: Shubham Vishwakarma <smsharma3121@gmail.com>
Date: Fri, 20 Mar 2026 07:11:37 +0530
X-Gm-Features: AaiRm50gksdLeOkJiHAJKsBo1R6Ua6hDecBRnL9xvjhP7-2EcXl9rRSS4j6-6X0
Message-ID: <CAPs1YC783sDcpKmvbFBsDuRCHLiiexquQnWeVhmGRQk9aOcO3g@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix QPL job leak on early error paths
 in z_erofs_decompress_qpl() After z_erofs_qpl_get_job() succeeds, two
 early-return error paths bypass z_erofs_qpl_put_job(), leaking the QPL job
 handle: - Line 200: return -EFSCORRUPTED (when inputmargin >= inputsize) -
 Line 205: return -ENOMEM (when malloc fails for decodedskip buffer) Fix by
 replacing the bare returns with goto out_inflate_end, which already handles
 both z_erofs_qpl_put_job() and free(buff).
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Ajay Rajera <newajay.11r@gmail.com>, linux-erofs@lists.ozlabs.org, yifan@pku.edu.cn
Content-Type: multipart/alternative; boundary="000000000000e543ca064d6ac941"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [2.30 / 15.00];
	LONG_SUBJ(3.00)[477];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2870-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[smsharma3121@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:yifan@pku.edu.cn,m:newajay11r@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.315];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smsharma3121@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,pku.edu.cn];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: E592A2D4D5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000e543ca064d6ac941
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gao and Ajay,

Thank you for the review and for pointing that out.

I apologize for the formatting; I made a mistake while using the CLI SMTP
instead of my usual Gmail GUI. I will correct the subject line and commit
message body and resend the patch shortly.

Thanks,
Shubham Vishwakarma

On Fri, Mar 20, 2026 at 7:07=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com>
wrote:

>
>
> On 2026/3/20 09:16, Ajay Rajera wrote:
> > Hi Vi-shub,
> > just a review :
> > I think the fix looks correct and it is the right approach but the
> > commit message formatting needs work. The entire description is in the
> > subject line. Per kernel conventions, the subject should be a short
> > one-liner, e.g: erofs-utils: lib: fix QPL job leak on early error
> > paths
> > The detailed explanation (which error paths leak, why, and how the fix
> > works) should go in the commit message body, separated from the
> > subject.
> >
> > So you can resend with the subject/body split fixed? so It will look
> more clear.
>
> yes, the commit message is in a mess.
>
> Thanks,
> Gao Xiang
>
> > Thanks, Ajay
>
>

--000000000000e543ca064d6ac941
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gao and Ajay,</div><div><br></div><div>Thank you f=
or the review and for pointing that out.</div><div><br></div><div>I apologi=
ze for the formatting; I made a mistake while using the CLI SMTP instead of=
 my usual Gmail GUI. I will correct the subject line and commit message bod=
y and resend the patch shortly.</div><div><br></div><div>Thanks,</div><div>=
Shubham Vishwakarma</div></div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026 at 7:07=
=E2=80=AFAM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hs=
iangkao@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><br>
<br>
On 2026/3/20 09:16, Ajay Rajera wrote:<br>
&gt; Hi Vi-shub,<br>
&gt; just a review :<br>
&gt; I think the fix looks correct and it is the right approach but the<br>
&gt; commit message formatting needs work. The entire description is in the=
<br>
&gt; subject line. Per kernel conventions, the subject should be a short<br=
>
&gt; one-liner, e.g: erofs-utils: lib: fix QPL job leak on early error<br>
&gt; paths<br>
&gt; The detailed explanation (which error paths leak, why, and how the fix=
<br>
&gt; works) should go in the commit message body, separated from the<br>
&gt; subject.<br>
&gt; <br>
&gt; So you can resend with the subject/body split fixed? so It will look m=
ore clear.<br>
<br>
yes, the commit message is in a mess.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; Thanks, Ajay<br>
<br>
</blockquote></div>

--000000000000e543ca064d6ac941--

