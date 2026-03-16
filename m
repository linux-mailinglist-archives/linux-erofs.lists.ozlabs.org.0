Return-Path: <linux-erofs+bounces-2739-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGKoKYTLt2kRVQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2739-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 10:21:08 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A6296DDC
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 10:21:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ8hv2Ywdz2xln;
	Mon, 16 Mar 2026 20:21:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773652863;
	cv=pass; b=nFfhXg0WnSlVgSG89Gt7O5HmQTLojS6Syhf9qcQiuDnMm9fcc4jNzDWoPueaDqUU6aIYRuPnNy7O/qYimZLn7LqXuJZ645MEZfvRYrHqM9Eac6PwUOR9Jl6uOj0ftw4sW5RZBfJbpo4tZgh2ALPmqRVwVNxL+xf4aG96qWe7b+aCG5iGgilFA3ouF05KP/eW2PAOQnGXuFfMPKjKmhKwq45zXXzXifR7kHEtNMU3UnbRufGJCCJiY9k0dmFstvIKOD8nlAyFLR8Z6Qwp4jp4+h9HoFViPHP+laQd6X1wN5Xm0xXDIcnxbfcch0IbWRZgXSraXrn4cZixJsWvZBkhWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773652863; c=relaxed/relaxed;
	bh=qrJODYt9JBMAZbq5a/AgvwsWuuLgnMJT6FWK6CBvwHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNIRThm7sVCdPZ7XqqlBWjG0iEVVC+tWHcGahoHQp8irbHP1mbS+45RhjjBwQLxTGp8Wao0JDuWDdWFfO8S9JRzF6fpHhUXt5wYigXEf59G8t97FQB86Z+EgucplID6C3RDHza6BPBcdEPTbjQujhI6KhfIL1lTSVQ4lNf5W99ywatraOp53VPI3eb5E3gpZZquFMbxQjfZ2a33nvFLQrrOdy0TYA60RVvYtDxoS9zjyycW+fcpz1Pk5bXIsPH6H+LX2UM4iw+hI9wPkjZ8AO9sIiDNN9Aij5GbaI2XBKCGMJYc3cjjtpC3o91VHw2ZizWp/JypPC7xkEVY019py2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PEGpYy2t; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PEGpYy2t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ8ht0kZlz2xS5
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 20:21:01 +1100 (AEDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso287615466b.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 02:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773652858; cv=none;
        d=google.com; s=arc-20240605;
        b=XeeX3CbdDiHHH1vkOX9zMst0+2r2exz/ZkyCvaeaLuk8lML3L0hm/kWfzr+LAi7ehs
         4d3OTxKyX/gyu6wUOvAgtZgsJ2uWizoDpyV4rwNfQfZtY8nQHrZJZg5UfnGjj0plpbF+
         Okq5dr9J+2yUbz78Jrikf0m3MOQFdpBNDwK6XbsGNfgwaERBsB8XrpGuKRVTtkswMAZH
         GotKL/IuzxvbsmRHBTF744ctNC5EN+e3z19KLuETsgymOTyhx9EUCuAOPzAu5K+Xa8sm
         HKcY9z7Pg4Os25KriDuy14YGOspKMuQ8se2MWZTHPb4vLhB9lUZiXDSPAZMt/ShS9mCE
         /8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qrJODYt9JBMAZbq5a/AgvwsWuuLgnMJT6FWK6CBvwHw=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=C6LRpH9QNL88FszRZW0AGYGnVowVy8TebU3GUoWGxDbJz19A3qRfh/pr0l8XvGM+Ii
         nfRk6L0s9k0d5Upp/hwCBmQFRkDO8x/4Q1HMGTsSBsdhRXUrUIxYIiDsO85Hq2uOskdV
         Ol1IMk9/4eCc+kPtPh9092Z7kIpnNO/yZ8CI2zIl4B9ctSBz9775dIZQ6Sp3k0yyv8it
         CjtmggmdcQn0sjux5K16xGeo0qVewztuTsbgz700zo83Jw9K+N2vEW+DjG9g90GT3XME
         cHKn6vMKkPZFrU0yBks6XIDsFAa4APehg561PSIjDWFJQLluZ/xYgtR9gSqfuzo49pwt
         FNVg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773652858; x=1774257658; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrJODYt9JBMAZbq5a/AgvwsWuuLgnMJT6FWK6CBvwHw=;
        b=PEGpYy2t1qMyjr3uguX4YAXnum8LihULFzbs44lV4o7d9EeYS1cpDJ9xCDrozgbs9X
         gB4ypU13RtUYmsqEvvqMasjanxUztftg/+v7qH4yHZGofCil2RdslyfHc7SJvSE64gqx
         iY9+ifPyZxm03XhWuX+OxfY4W3DvZFHbHmNwmQg3l/tSgRLtpNIG5kAFl3AEGBPEODlI
         CcDzCRcQPOpjd4RstE5lXk63K7KVVcuzDXxyQEp7DwBBZbovRmtqeNXg5t4X2E+l8AqP
         v9UQABf55JCUuxdhgTggraFaY85j1IrZ6OC/Ir8E3MziSMFa87ISWHPU4GoF106wbaGp
         5zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773652858; x=1774257658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qrJODYt9JBMAZbq5a/AgvwsWuuLgnMJT6FWK6CBvwHw=;
        b=sGO1oQOp2mC4aWkJgbWBzkj32Cdx/Sc1ZRJ+DNRJ5bQtDtJvoxhaGKKvbbuuRkwXW0
         08NdJC4QR7j6eQNgNAGvTRvh7ycr9B2Llj+ANx2F2sjmpX+eDoGdDyBhvQ09VIt+DbzL
         yjBhlWY5Q4rOGDH5h92F7b+vfWlG87wd4yUThPei50ALlUcqpBj3vsurMOejteBv/Q57
         nYiM6UCj2KJA2bZWJ54uOsIS/yppomiqUnqG0+rUkDYDpOAyZDehNOdF1zBlG1NhbTrW
         ghfbMIcs3T9FQnMVdtMekDpISdllNPBo2ocrFA5KAS9hBx10doJPnzvjDY2BDmqv0Ui4
         Fd/Q==
X-Gm-Message-State: AOJu0YziQfFRa9vNavCFA4eU3VDjbAae0UHaiB/SZN29lidPJ3knHh6p
	LlTtUmzs6yZ1UNqe89lGNGZdbCIzr9aCTp9XZcqdVNk94yZSthE5dwlaqLu/shD718mj2fX3wxG
	DlQvxe691nbSs3pu9mYb72GArsJ3BJ/Lazg1qQCNGUw==
X-Gm-Gg: ATEYQzxOz72BM//AFuIAnlIjx1iMCzX0XNBd6ztVxqk5HrI6ZrYBQNrwKXrCy7b+RGV
	s3E6ptceTIWcwyvMuoWbxt69Towl76pFW8NTSyIbCENXAg3AuohS0Sk/cI3haGKEYJg6f8g9pYN
	Gcyjyb6DRDgEBYhpYzla7Fc82JmVRAnv5ETNEF1I2vb2zK0N39UkdeyPwG0T/zccsnUca/gyiab
	Ufi135QToUjhUSPVExlcFBnIZf8BLyZ0ChgS8B/AQb3XGtqQCEHf3/3/to8o1FlWrZApCGB9HWe
	0XvACfL3hwOn+1hoENo=
X-Received: by 2002:a17:906:c114:b0:b97:8503:8313 with SMTP id
 a640c23a62f3a-b978503a6bcmr489838066b.27.1773652857800; Mon, 16 Mar 2026
 02:20:57 -0700 (PDT)
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
References: <CABDnCWmf7NkT75a5zHAzixbLxpKSdK1s35GBC8d1s=-YosBncA@mail.gmail.com>
 <3781ee92-cdc9-47df-a8f1-7f5b514907f5@linux.alibaba.com>
In-Reply-To: <3781ee92-cdc9-47df-a8f1-7f5b514907f5@linux.alibaba.com>
From: Sri Lasya Prathipati <lasyaprathipati@gmail.com>
Date: Mon, 16 Mar 2026 14:50:46 +0530
X-Gm-Features: AaiRm52vnXi6qyRY8Yups4CGVdL1OoqQiWvpUU4E571tbzLnSl8zkxRT54a7rcA
Message-ID: <CABDnCWkO=z5KD9Jkc6_nTj4FYggi3T7RDALUO9dGgxUEKACfbQ@mail.gmail.com>
Subject: Re: [GSoC] Inquiries regarding manifest format and implementation strategy
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2739-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 0B1A6296DDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Gao,

Thank you for the clear direction on the format priority and the
integration path.

Based on your feedback, I am structuring my GSoC proposal to
prioritize the composefs-dump style manifest as the primary milestone.
I will design the parser to act as a "virtual source" within the
mkfs.erofs framework, ensuring the architecture is modular enough to
add support for Unix-style proto files as the second phase.

I am currently finalizing the technical timeline and the architectural
design for this virtual source logic. I look forward to sharing the
full proposal soon.

Best regards,
Sri Lasya

On Mon, Mar 16, 2026 at 7:18=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2026/3/16 03:34, Sri Lasya Prathipati wrote:
> > Hi Gao and the EROFS Community,
> >
> > As I am finalizing my GSoC 2026 proposal for the project "Support
> > generating filesystems from manifests," I have been researching the
> > various manifest formats mentioned in the project ideas.
> >
> > To ensure my proposal aligns with the community's vision for
> > erofs-utils, I have two specific questions:
> >
> > Format Priority: Should the initial focus be on implementing a parser
> > for Unix-style proto files (similar to genext2fs), or is there a
> > stronger preference for supporting composefs-dump style manifests from
> > the start?
>
> I think you could finish `composefs-dump` style first, and then
> Unix-style proto files.
>
> As written in the idea page, it should support two formats at
> least.
>
> >
> > Integration Path: In mkfs.erofs, do you envision the manifest parser
> > acting as a "virtual source" that replaces the standard directory
> > crawling logic, or should it coexist as a hybrid approach?
>
> I think it's up to you, the hybird approach won't be hard if you support
> the pure "virtual source" one.
>
> Thanks,
> Gao Xiang
>
> >
> > I believe clarifying these points will help me provide a more accurate
> > and realistic timeline in my application. I've already begun looking
> > into the mkfs source to see where the insertion point for a new input
> > frontend would be most efficient.
> >
> > Looking forward to your guidance!
> >
> > Best regards,
> > Sri Lasya prathipati
>

