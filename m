Return-Path: <linux-erofs+bounces-1113-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD0BA2C8E
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Sep 2025 09:31:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cY2MX3fTbz300F;
	Fri, 26 Sep 2025 17:31:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758871896;
	cv=none; b=UCFrv/yvAjCBZu8lcdG1mKHnCQ5YDyBln9SctTMFs9FD3/+DPTGcjriWxwcUvheDTC2W0INHqozhWKVUG8FO9+tKIJHNU5+Ruct+R8JUh7ktVbOGiPiBLlCHz+7JFqtdJ4t5oHKLJTMXOTgt+iKOQKuRm6tcYiUrevfPBC2wUMkix2wk4yBVil4rIN9N5cowpEGidDjmYzA9QspW8v51YrVYyG+n2vFaCIBy1euLRV+CwMDw6YjhC51iqI52idWANfblyqzGQaOm/hJUOsZEWgCU78aRKCsStl2y0zQYcK1KT4uCqrZqSZIBzAHzs0nB8VwDdd/ZwgXm8o7P2YwIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758871896; c=relaxed/relaxed;
	bh=zN4peVxWL0zSknKb/nxU8BZxb2xqfgd1C45ub1DITH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpvpZM/3rOSJ7DT/XTADBdxUXTpP8fXjkfjvcGhONrdax+8QHAX2wP5JT+rqP3UEOoWxYhermKMHqyvL4Um9oYGdxJnAQin+o5pEwEjdSq819lX0ApzBQgJHyGtCtLQ4XPY+F4jMkFLDuXQg69XVpP0/zfG/nDWAGjWzJa5Vi9YMDp/KB+O+Aayfl65q8XVf2gY0/LOQ6af5SjUFwP41tmybVkgVNoxxKV4siYFf+bifZPyX4yNpmrWwv6gkEgCWc6hH81cbIL2KWDk96kbL50YajnjDd48Y0D+x2tn7XZgjPn8zQqFU0SJhXvbIgLUSqkrjKYIkVyJvdpyCWOB0xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CQejgPi4; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CQejgPi4; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CQejgPi4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CQejgPi4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cY2MW1ln0z2ypW
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 17:31:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758871888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zN4peVxWL0zSknKb/nxU8BZxb2xqfgd1C45ub1DITH8=;
	b=CQejgPi4wzHkxrgftL9b2/zM5OiRYeb3/RMe7iSnnhrWVqfp3W+AeC79TSJl1a7il6R+P/
	kO8PvnlixWp1yuRye4kzHBgBTtr8D5yRATbYCO+yPRouh+OKwVE7k7+ThFx7j8d7gTGUOm
	sxOkzi5P1M28jQexKkCM2ywtk5/pT/8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758871888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zN4peVxWL0zSknKb/nxU8BZxb2xqfgd1C45ub1DITH8=;
	b=CQejgPi4wzHkxrgftL9b2/zM5OiRYeb3/RMe7iSnnhrWVqfp3W+AeC79TSJl1a7il6R+P/
	kO8PvnlixWp1yuRye4kzHBgBTtr8D5yRATbYCO+yPRouh+OKwVE7k7+ThFx7j8d7gTGUOm
	sxOkzi5P1M28jQexKkCM2ywtk5/pT/8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-tGI8Kk0EOIiMonFPbJ__3Q-1; Fri, 26 Sep 2025 03:31:26 -0400
X-MC-Unique: tGI8Kk0EOIiMonFPbJ__3Q-1
X-Mimecast-MFC-AGG-ID: tGI8Kk0EOIiMonFPbJ__3Q_1758871885
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso13657765e9.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871885; x=1759476685;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN4peVxWL0zSknKb/nxU8BZxb2xqfgd1C45ub1DITH8=;
        b=jgOQ9Tb1aDwl4+C9LdeVy+HJ0D6nQKZxe5t4ciHr8VNIDyVkErHTvq8hJs+Y60s3Et
         2zks6rZXlHKh0+YwjrT5BleAWcPhwQZmKdxo6P7S7QgAZ5AllLqQC9TlQcPx0ul4c0X4
         05XTO/0PieU4TCpL3QyI700JYf14TML/CotjLavge/Kkc6plxzIlVx4m2gZ0ynfYYZ+s
         0N9vRmzpOwN/I3P5GaW1RwPKOLTRN5acyyV6zE5AurQ3mNt60CPXJs9yYEr4a+AXYpVh
         4uncSPMOPRWq6s8B2bKPb0YqaWVxXiD2TelbKgPxiBmz8/2eYcGOAfuLB5xjFYU+qyde
         QX/w==
X-Forwarded-Encrypted: i=1; AJvYcCX28d9UVNZK7I2rxeJjzarjqNMaeORg3Ma0NrPgxgGype6qpAnZlOp7TVRkZytOHW/jPkyQY86zbeICNg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwPwLWCRqnstXqFG7Z67943EB+IP7xutrhkZ2t9FdwMr5ILMxcN
	8iVYHVZFCXBHcl5k01HzO8OtVOxJBqk0HV94y4uLIceIfCuZ75wJpEHuiW7adKOc/OAVaAmp7Yl
	BV9AZLRk5X0+ertv6f9EkT5Kpr3mk2SF5n3PXFw+Qjia2c727voc/X91gDHezY30PiA==
X-Gm-Gg: ASbGncsliv7AQ4Ah8vjJgsw4+rnB07DQ8JWhzeUcjoUVpXp+S1Ulu7/2gV2okkv1Tb6
	sRJS7/hs8a3HbzLMy+HHGUDrkrSioGAqQ3kgZiw9aaqTQyTDJV311Snw26TSQ6Rl86wCKgm8fWE
	UNiVnfI2UdzjUbxcMwp7MO+ANS6Y6YZRWlgIqEO8gJpr+iymMa3EleRDVMAsddpSuplWwNgS6Oj
	xc7JMbopXntYwGoJikNcVvU+a61uiRCIBD4MS1TZtO6LbFah5ZGh5Dvy/c7yJTnMIHfKpAt8V0P
	bJqOFNnEoV1RkuceF0H53uAyGVEaImdlr6f0rbUPZw4ndtpnG284WE5qyRAPw5oNgcDRRFSoCYp
	SbSlb4l61znd6kFuiJBxNPAUOsBouR/CyVtmApgU8NIQ1FEfa9izduxypmHx+pueTCatk
X-Received: by 2002:a05:600c:3ba9:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-46e329f9c61mr65568725e9.20.1758871884790;
        Fri, 26 Sep 2025 00:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdCFTWN0OMV/8re7i7X1C3LDq1oeLqj0b7w/lVtU1L4ASh3eR7s8IXfpyY0kZjgB5RF7jO9w==
X-Received: by 2002:a05:600c:3ba9:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-46e329f9c61mr65567615e9.20.1758871884155;
        Fri, 26 Sep 2025 00:31:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:c100:5d3c:50c0:398a:3ac9? (p200300d82f34c1005d3c50c0398a3ac9.dip0.t-ipconnect.de. [2003:d8:2f34:c100:5d3c:50c0:398a:3ac9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm105756545e9.20.2025.09.26.00.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 00:31:23 -0700 (PDT)
Message-ID: <95ace421-36d2-48af-b527-7e799722eb17@redhat.com>
Date: Fri, 26 Sep 2025 09:31:19 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
To: Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org,
 chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com,
 kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, ackerleytng@google.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-10-shivankg@amd.com> <aNW1l-Wdk6wrigM8@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNW1l-Wdk6wrigM8@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rdnRXaonscoI2KvvOr9X9vhkUnBsWYzfUX2F0_w8O1g_1758871885
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 25.09.25 23:35, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Shivank Garg wrote:
>> Add tests for NUMA memory policy binding and NUMA aware allocation in
>> guest_memfd. This extends the existing selftests by adding proper
>> validation for:
>> - KVM GMEM set_policy and get_policy() vm_ops functionality using
>>    mbind() and get_mempolicy()
>> - NUMA policy application before and after memory allocation
>>
>> These tests help ensure NUMA support for guest_memfd works correctly.
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>>   .../testing/selftests/kvm/guest_memfd_test.c  | 121 ++++++++++++++++++
>>   2 files changed, 122 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
>> index 90f03f00cb04..c46cef2a7cd7 100644
>> --- a/tools/testing/selftests/kvm/Makefile.kvm
>> +++ b/tools/testing/selftests/kvm/Makefile.kvm
>> @@ -275,6 +275,7 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
>>   	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
>>   
>>   LDLIBS += -ldl
>> +LDLIBS += -lnuma
> 
> Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
> any of my <too many> systems, and I doubt I'm alone.  Installing the package is
> trivial, but I'm a little wary of foisting that requirement on all KVM developers
> and build bots.
> 
> I'd be especially curious what ARM and RISC-V think, as NUMA is likely a bit less
> prevelant there.

We unconditionally use it in the mm tests for ksm and migration tests, 
so it's not particularly odd to require it here as well.

What we do with liburing in mm selftests is to detect presence at 
compile time and essentially make the tests behave differently based on 
availability (see check_config.sh).

-- 
Cheers

David / dhildenb


