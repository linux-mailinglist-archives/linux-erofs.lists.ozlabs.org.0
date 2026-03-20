Return-Path: <linux-erofs+bounces-2873-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJQcHH6svGnz1wIAu9opvQ
	(envelope-from <linux-erofs+bounces-2873-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 03:10:06 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8524E2D5038
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 03:10:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcQxk5Jcqz2xm3;
	Fri, 20 Mar 2026 13:10:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::329" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773972602;
	cv=pass; b=Mf6Iq7IiPm2qgxSRx60hzzttOdtfc1nIAYv4Q784mMWiWt0ywrZsKKey9btAJE2MylHBIepWO6oyNdabVwohPqTujLK8r003yF8wZjGBxFWsUYxwgbWZnhn/kE0FUZonZqyNcWOOEKDeTYMUqu4ZLXk+1k5NB3blMfWwqruoUNL+i8u7Mu4TODQgXj1tURgs1tM0KH7seBzfc+TjdtpFlpDBj2XmuLKbjgJIg5MpQRhvxXsewCEvZrbr0AurjxmKhf1nKrxD7jr3Jz6GfhQ6j7I8K1w+roccxmEzTxBNY7AsONz+f7JnaOuxp5d7tSA+wQyl5rk5TKHiB1v4FbC5Qw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773972602; c=relaxed/relaxed;
	bh=n6bx+m8hFr3iCcJL5Wct20Kt1o+LjM7g3//cLsQ3ow8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByZQbBGXLnNgrVGCihn+bv05Gmwekr7InZUJcI3tadOnepjos9B0g4SQF7S37NLGCON20WXtJJ9G8UFsyXtvZ1Kf+awmA6qcShqsHbOncSwjuUkdPjvwyWVm3b2nl8vxs3FJyYRygoO0EM2aZR1iR3l+jxtjDX/apocSZpAlcbJCRWDHicknBaSSjxScInoXpBiV5nqiI3mbgToiguucYNuIaQ+73O13Z2ll0jO72+GR+a0A2MzA1AQIN4uo+OnGQysNtyrIqlotvF8zawTBKBer+8c4K5XczMypY4SJPXWLH0wDX2FW5FtEUIPbfORbvnfAqZwkZTsmj7ER0UQp1Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=c1wHLpIQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=c1wHLpIQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcQxj3r5Fz2xly
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 13:10:01 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so988905e9.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 19:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773972597; cv=none;
        d=google.com; s=arc-20240605;
        b=KZSzXIH0QH8y9RcnSiLmKuWmg5+9q6F56mHxeauH0MPP4a33/qwxnsbtr16jST35Gh
         STYf9ABaXA6H4oCVBvpna+SLE7mDm9bdWLWa3NlBnf9KnxJ83xIKCZd57+9sRJiz1zjY
         8boVHqVD17yHtFPjio8z5WOXwWZho5F6PeLuncKE0POA/VflFUHOVMBi3FOh1LhSp20T
         Pt9IU1yKUWgkDagN4O4+HHNUe6BbLiS9WcfBizCiuhXd29UEqz8PlOL5CbkIPkoCA+a4
         eTyasShryo7TTfWGaSWqFFt5TUP6rzRWKxPtjhqFvaYwaMtLIH/Tt6P0De+Lc7X9SMg+
         1ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n6bx+m8hFr3iCcJL5Wct20Kt1o+LjM7g3//cLsQ3ow8=;
        fh=TwmOCR/vHa39m12klCwIr3IKqBXF/DoRIQd60qfsAwU=;
        b=MBDDL78p7gakcElPRYgzrKmGtw+nO17ODvpl99BNgwegu9LPM5lJ/rzi/Pf6+lpadH
         slYPKxcHcFV5TmQ2DE2iD4F6ayBcIpKOH+6tcSYbPRdbA8i6uvDuv3BJR4fcOUa8PZCj
         Mc9AW0warBKh1GF+LQd+MIxsgAfHQq7QCGvaRmPDaCATuHooVkeQuoGDWN5n5tJXL6qL
         AChkD0mNgNv2k8fb6/G8S4EpQF0/i/cAjOxTAcfrIN9fD/vdC/njlunnLlJi2fxs1MTK
         sCfP1yFTSEIvyv4uZ9/Qi5y3Kk+Pnqj+z/agctGMhpKepelXGXxoCUwS8eFlM63cnKu1
         q4Hg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773972597; x=1774577397; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6bx+m8hFr3iCcJL5Wct20Kt1o+LjM7g3//cLsQ3ow8=;
        b=c1wHLpIQ9CV5QnlMfP2yCi0NuVaeknoJZANcTIVf/PQAkX8PtXWFsH8tC/JtAIY7lz
         woHUWVcxEXCzn7k5xousWzwpPq26pUmBkZQCqzbu2gBTWCMCKrW93QapCHqnrDyP4NVO
         PbBtvf+PzKBAeVtQpDm7sxCQoIoH4XCodEY59YJzrpMJ/yCyMxtsWZv43yiWZrBoTR1D
         oqVeFWll7km2MDrOv/V4XyFgZI7a76vry/Nky0wUB+GBNeuc/n0D/UK03v/UouXVQNej
         EjoHDtUpc4lrZIL/j8PzCc7sGXbU3Zrxi7EJCIQWMLfhI80+kcFN4U9RA6ZFJ6gS3H7u
         f3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773972597; x=1774577397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6bx+m8hFr3iCcJL5Wct20Kt1o+LjM7g3//cLsQ3ow8=;
        b=E3ZKtYM0ZliSR0AMYtdkJPM2Q+GNjuF6w9P+XT4gZ2ANp9XHHsYl+mz4X7hrLCTg9i
         WScbSJDZd/VCVNe3oz1OnKqQEfAW6xaluuKtzovOrYH+gIvxBOcLVFBL1F+oo2nFdPJF
         DFF36Sh2vM6zdtmWW+C4ue8pTOrkS6uRjFenlQaMptu5LaN6YWyIe+0g4fbiivuQpTMb
         V/0bvIh74ajh+e4S3ZxpVHdiZ4ax/kt6JNz6/msvNycBAvlzf3kJKnnQccnwUG3HEEkG
         K6LLEZa2U10gtiBYBEgg+KAXn0gu+RctYVhCKOj0Vcg5ay4fosSpZ69H7vTh9zWGobE+
         XdVg==
X-Forwarded-Encrypted: i=1; AJvYcCVx4M8UeRICaGyGPFcjjY39Cx9ac+5rnhq5b9skDCyp9AXQADGAVlc9lON7Q+YgM2OovGKE0Jw2yKFcMw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxyvQ+qbUNXMqyNeEiI10k93/4wjQdsTtiTXXA8jDJgEW8JyJDH
	fx6H35ovCJyEIwm66OiZPMwF/gYChyPhuOQMn+lZ+4WXFqkyQxBizko115LiPi7cV/dg9m7RDaL
	oocgHkkAv2lvd1KaHaBLyKkNuPuchypnT2FNGRmY=
X-Gm-Gg: ATEYQzyIpcuDLqrk8fxn4TpzmA4jtFQw368vq0xlmkAsv1fx3HPkC35VBVBmXTEOm+r
	FqkRaXbh3pWpK0CiRdkwic9W6HzulGsiI/ZjY+Aaz6fgGiD2MbidnG9wDfTmr0EFQJ09EJ64GdC
	9ftqpqj322uxuNroetO6ZUHU9CGy4ICjys9opdDw3KwWbWeqJSXEIsF6lkoUtQw2FHBNFk97ByH
	0voqJDRDG86VZmP/dPNeK9ytyK02J3zLhblua6A58IntRZNTSowfFlu30Kp25mvY4u354o+xz0f
	oazA6GtF6JOgJ5CXkmn9px7v6AdQR0NGe16AbA==
X-Received: by 2002:a05:600c:698e:b0:486:f4d2:eac6 with SMTP id
 5b1f17b1804b1-486fedd80c9mr15987885e9.13.1773972597016; Thu, 19 Mar 2026
 19:09:57 -0700 (PDT)
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
 <0b0ad26c-f462-4274-aaad-6a8e079c0963@linux.alibaba.com> <CAPs1YC783sDcpKmvbFBsDuRCHLiiexquQnWeVhmGRQk9aOcO3g@mail.gmail.com>
In-Reply-To: <CAPs1YC783sDcpKmvbFBsDuRCHLiiexquQnWeVhmGRQk9aOcO3g@mail.gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Fri, 20 Mar 2026 07:39:45 +0530
X-Gm-Features: AaiRm50vfywEYANcDJgBzm9pjiO8F02OnpHEe9PmQATmSLahEpKonTl8rGEnQP8
Message-ID: <CAMhhD9gKj32d6qf=_Z83KW=NJA0bF1=BCu9zQ-Ec-ZxkwTPP_g@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix QPL job leak on early error paths
 in z_erofs_decompress_qpl() After z_erofs_qpl_get_job() succeeds, two
 early-return error paths bypass z_erofs_qpl_put_job(), leaking the QPL job
 handle: - Line 200: return -EFSCORRUPTED (when inputmargin >= inputsize) -
 Line 205: return -ENOMEM (when malloc fails for decodedskip buffer) Fix by
 replacing the bare returns with goto out_inflate_end, which already handles
 both z_erofs_qpl_put_job() and free(buff).
To: Shubham Vishwakarma <smsharma3121@gmail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.80 / 15.00];
	LONG_SUBJ(3.00)[477];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-2873-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:smsharma3121@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.971];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,mail.gmail.com:mid,pku.edu.cn:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 8524E2D5038
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hi, I just want to let you know that this email address
<yifan@pku.edu.cn> is incorrect, the recipient doesn't exist so it is
better to not use it anymore.
Thanks, Ajay Rajera.

On Fri, 20 Mar 2026 at 07:11, Shubham Vishwakarma
<smsharma3121@gmail.com> wrote:
>
> Hi Gao and Ajay,
>
> Thank you for the review and for pointing that out.
>
> I apologize for the formatting; I made a mistake while using the CLI SMTP=
 instead of my usual Gmail GUI. I will correct the subject line and commit =
message body and resend the patch shortly.
>
> Thanks,
> Shubham Vishwakarma
>
> On Fri, Mar 20, 2026 at 7:07=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibab=
a.com> wrote:
>>
>>
>>
>> On 2026/3/20 09:16, Ajay Rajera wrote:
>> > Hi Vi-shub,
>> > just a review :
>> > I think the fix looks correct and it is the right approach but the
>> > commit message formatting needs work. The entire description is in the
>> > subject line. Per kernel conventions, the subject should be a short
>> > one-liner, e.g: erofs-utils: lib: fix QPL job leak on early error
>> > paths
>> > The detailed explanation (which error paths leak, why, and how the fix
>> > works) should go in the commit message body, separated from the
>> > subject.
>> >
>> > So you can resend with the subject/body split fixed? so It will look m=
ore clear.
>>
>> yes, the commit message is in a mess.
>>
>> Thanks,
>> Gao Xiang
>>
>> > Thanks, Ajay
>>

